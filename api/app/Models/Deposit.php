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

class Deposit extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;
  public $table = "deposit";

  protected $fillable = [
    'depositID',
    'trxId',
    'depscription',
    'gaming_pltform_id',
    'cryptoType',
    'user_id',
    'deposit_amount',
    'orderId',
    'receivable_amount',
    'payment_method',
    'approved_by',
    'depsoit_images',
    'to_crypto_wallet_address',
    'currencySymbol',
    'bank_name',
    'account_name',
    'account_number',
    'ific_code',
    'swift_code',
    'others_code',
    'inputAmount',
    'countryId',
    'country_wise_bank_id',
    'status',
  ];
}
