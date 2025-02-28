<?php

namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use App\Models\AttributeValues;
use AuthorizesRequests;
use DB;

class Trade extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;
  public $table = "trade";
  
  protected $fillable = [
    'tradeID',
    'unique_md5',
    'user_id',
    'market_price',
    'trade_amount',
    'close_price',
    'status',
    'selected_duration',
    'selected_percentage',
    'action_type',
    'selectedCurrency',
    'request_datetime',
    'start_datetime',
    'end_datetime'
];


}
