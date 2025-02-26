<?php
namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use AuthorizesRequests;
use DB;
class CountryWiseBank extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    public $table = "country_wise_bank";
    protected $fillable = [
        'add_bank_id',
        'country_id',
        'bank_name',
        'account_name',
        'account_number',
        'ific_code',
        'swift_code',
        'others_code',
        'status',
    ];
}
