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

class MakePlayers extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;
  public $table = "players";
  
  protected $fillable = [
    'user_id',
    'account',
    'api_key',
    'api_code',
    'username',
    'password',
    'show_password',
  ];
 
}
