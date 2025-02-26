<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AddCountry extends Model
{
    public $table = "add_country";
    protected $fillable = [
        'country_id',
        'currency_id',
        'status',
        'usdt_rate',
        'created_at',
        'updated_at',
    ];
}
