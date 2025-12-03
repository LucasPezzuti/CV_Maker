<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cv_experiences', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cv_profile_id')->constrained()->onDelete('cascade');
            
            $table->string('puesto');
            $table->string('empresa');
            $table->string('ubicacion')->nullable();
            $table->date('fecha_inicio');
            $table->date('fecha_fin')->nullable();
            $table->boolean('trabajo_actual')->default(false);
            $table->text('descripcion')->nullable();
            $table->json('logros')->nullable(); // Array de logros
            $table->integer('orden')->default(0);
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cv_experiences');
    }
};