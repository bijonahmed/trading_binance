<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MobileBanking extends Model
{
    public $table = "mobile_banking_setting";
    protected $fillable = [
        'country_id',
        'name',
        'status'
    ];
}
