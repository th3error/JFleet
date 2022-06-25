<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\SeatBookingService;
use App\Services\SeatAvailabilityService;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    /**
     * Return Available Seats IDs given trip stations
     *
     * @return \Illuminate\Http\Response
     */
    public function availableSeats(Request $request)
    {
        $request->validate([
            'start_station'  => 'required|string|alpha',
            'end_station'    => 'required|string|alpha',
        ]);

        $seatServiceInstance = new SeatAvailabilityService;
        $seatServiceResponse = $seatServiceInstance->getAvailableSeats($request);
        return $seatServiceResponse;
    }
    /**
     * Book seat for trip
     *
     * @return \Illuminate\Http\Response
     */
    public function bookSeat(Request $request)
    {
        $request->validate([
            'start_station' => 'required|string|alpha',
            'end_station'   => 'required|string|alpha',
            'seat_id'       => 'required|integer|numeric'
        ]);

        $availableSeatsResponse = $this->availableSeats($request);
        $availableSeatsResponseData = $availableSeatsResponse->getData();
        $availableSeatsArray = $availableSeatsResponseData->available_seats;
        $tripId = $availableSeatsResponseData->trip_id;
        if ($availableSeatsResponse->status() == 200 && is_array($availableSeatsArray)) {
            $seatId = $request->seat_id;
            $isSeatAvailable = in_array($seatId, $availableSeatsArray);
            if ($isSeatAvailable) {
                $seatBookingInstance = new SeatBookingService;
                $seatBookingResponse = $seatBookingInstance->BookTrip($seatId, $tripId);
                return $seatBookingResponse;
            }else {
                return response()->json([
                    'message' => 'Seat has been taken, please choose another'
                ], 409);
            }
        } else {
            return $availableSeatsResponse;
        }
    }
}
