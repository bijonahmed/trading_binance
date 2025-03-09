<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BankSetting extends Model
{
    public $table = "bank_setting";
    protected $fillable = [
        'country_id',
        'name',
        'status'
    ];
}
