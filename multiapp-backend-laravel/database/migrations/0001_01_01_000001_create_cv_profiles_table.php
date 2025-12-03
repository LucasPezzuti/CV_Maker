<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cv_profiles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            
            // Información personal
            $table->string('nombre');
            $table->string('apellido');
            $table->string('email');
            $table->string('telefono')->nullable();
            $table->string('direccion')->nullable();
            $table->string('ciudad')->nullable();
            $table->string('codigo_postal')->nullable();
            $table->string('linkedin')->nullable();
            $table->string('github')->nullable();
            $table->string('portfolio')->nullable();
            
            // Perfil profesional
            $table->string('titulo_profesional')->nullable();
            $table->text('resumen_profesional')->nullable();
            
            // Configuración
            $table->string('template', 50)->default('modern');
            $table->json('configuracion')->nullable(); // Para guardar colores, etc.
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cv_profiles');
    }
};