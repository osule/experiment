<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TestController;

Route::post('/test', [TestController::class, 'test']);