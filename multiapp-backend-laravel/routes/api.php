<?php
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CvController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);
    
    // Rutas para el CV
    Route::get('/cv', [CvController::class, 'index']); // Obtener CV del usuario
    Route::post('/cv', [CvController::class, 'store']); // Guardar/actualizar CV
    Route::get('/cv/generate-pdf', [CvController::class, 'generatePDF']); // Generar PDF del CV
});