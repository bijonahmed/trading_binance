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

class StarVideoGallerys extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;
  public $table = "star_video_gallary";
  
  protected $fillable = [
    'id',
    'name',
    'slug',
    'video_source_link',
    'thumnail',
    'status',
  ];
 


}
