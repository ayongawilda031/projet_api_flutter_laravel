<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\FavoriteController;

Route::get('/categories', [CategoryController::class, 'index'])->middleware('auth:sanctum');
Route::get('/category/product/{id}', [CategoryController::class, 'fetchProductUnderCategory'])->middleware('auth:sanctum');
Route::get('/products', [ProductController::class, 'index'])->middleware('auth:sanctum');
Route::get('/product/{id}', [ProductController::class, 'viewProduct'])->middleware('auth:sanctum');

Route::get('/favorites', [FavoriteController::class, 'index'])->middleware('auth:sanctum');

Route::post('/product/favorite/{id}', [FavoriteController::class, 'addFavorite'])->middleware('auth:sanctum');

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/cart/add/{product_id}', [CartController::class, 'addToCart']);
    Route::get('/cart', [CartController::class, 'getCart']);
    Route::put('/cart/update/{cart_id}', [CartController::class, 'updateCart']);
    Route::delete('/cart/remove/{cart_id}', [CartController::class, 'removeFromCart']);
});

