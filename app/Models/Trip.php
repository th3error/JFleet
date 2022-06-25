<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Trip extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'start_station_id',
        'end_station_id',
        'bus_id',
        'inbetween_trip_ids'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'inbetween_trip_ids' => 'array',
    ];

    /**
     * Get the reservations for the trip.
     */
    public function reservations()
    {
        return $this->hasMany(Reservation::class);
    }
}
