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

class UserPaymentAddress extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;
  public $table = "add_user_payment_address";

  protected $fillable = [
    'user_id',
    'name',
    'wallet_address',
    'mobileBanking',
    'mobileaccountNumber',
    'mobile_bank_country',
    'bank_country',
    'selected_bank',
    'bankAccountName',
    'bankAccountNum',
    'type',
    'status'
  ];
}
