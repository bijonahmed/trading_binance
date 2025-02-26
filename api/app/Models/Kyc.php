<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kyc extends Model
{
    use HasFactory;
    public $table = "kyc";
    protected $fillable = [
        'user_id',
        'dl_front',
        'dl_back',
        'frontFile_nid',
        'backFile_nid',
        'passport',
        'status',
    ];
}
