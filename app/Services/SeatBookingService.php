<?php

namespace App\Services;

use App\Models\Trip;
use App\Models\Reservation;

class SeatBookingService
{
  public function BookTrip($seatId, $tripId)
  {
    $trip = Trip::where('id', $tripId)->firstOrFail();
    $inBetweenTrips = $trip->inbetween_trip_ids;
    if (is_null($inBetweenTrips)) {
      $reservation = new Reservation;
      $reservation->main_trip_id = $tripId;
      $reservation->trip_id = $tripId;
      $reservation->user_id = 1;
      $reservation->seat_id = $seatId;
      $reservation->save();
      return response()->json([
        'message'     => 'Trip booked successfully',
        'seat_number' => $seatId,
        'trip'        => $trip->name
      ], 201);
    } else {
      foreach ($inBetweenTrips as $value) {
        $reservation = new Reservation;
        $reservation->main_trip_id = $tripId;
        $reservation->trip_id = $value;
        $reservation->user_id = 1;
        $reservation->seat_id = $seatId;
        $reservation->save();
      }
      return response()->json([
        'message'     => 'Trip booked successfully',
        'seat_number' => $seatId,
        'trip'        => $trip->name
      ], 201);
    }
  }
}
