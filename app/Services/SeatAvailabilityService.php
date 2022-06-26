<?php

namespace App\Services;

use App\Models\Bus;
use App\Models\Trip;
use App\Models\Station;
use App\Models\Reservation;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class SeatAvailabilityService
{
  public function getAvailableSeats($request)
  {
    // Get the Ids of cities/stations from user input
    $startStationId = $this->getStation($request->start_station);
    if (!is_numeric($startStationId))
      return $startStationId;
    $endStationId = $this->getStation($request->end_station);
    if (!is_numeric($endStationId))
      return $endStationId;

    // Get the trip if exists
    try {
      $trip = Trip::where('start_station_id', $startStationId)
        ->where('end_station_id', $endStationId)
        ->firstOrFail();
    } catch (ModelNotFoundException $exception) {
      return response()->json([
        'message' => 'Trip not found'
      ], 404);
    }

    /**
     * Get available seat ids
     */

    // All trips with same bus and common Trip
    $busId = $trip->bus_id;
    $inBetweenTrips = $trip->inbetween_trip_ids;
    if (is_null($inBetweenTrips)) {
      $commonTrips = Trip::select('id')
        ->where('start_station_id', $startStationId)
        ->orWhere('end_station_id', $endStationId)
        ->where('bus_id', $busId)
        ->get();
    } else {
      $commonTrips = Trip::select('id')
        -> whereIn('id', $inBetweenTrips)
        ->where('bus_id', $busId)
        ->get();
    }

    // Get all booked seats
    $bookedSeatIdArray = Reservation::select('seat_id')
      ->whereIn('trip_id', $commonTrips)
      ->get()->pluck('seat_id')->toArray();

    // Create bus seats array
    $seatsCount = Bus::select('seat_count')
      ->where('id', $busId)
      ->first()->seat_count;
    for ($i = 1; $i <= $seatsCount; $i++) {
      $allBusSeatIds[$i - 1] = $i;
    };

    // Compare booked vs all bus seats and get empty seat ids
    $availableSeatIds = array_diff($allBusSeatIds, $bookedSeatIdArray);
    foreach ($availableSeatIds as $key => $value) {
      $availableSeatIdsArray[] = $value;
    }

    return response()->json([
      'trip_id'            => $trip->id,
      'available_seats' => $availableSeatIdsArray
    ], 200);
  }

  private function getStation($stationName)
  {
    try {
      $stationId = Station::where('name', $stationName)->firstOrFail()->id;
      return $stationId;
    } catch (ModelNotFoundException $exception) {
      return response()->json([
        'message' => 'City not found. ' . $stationName
      ], 404);
    }
  }
}
