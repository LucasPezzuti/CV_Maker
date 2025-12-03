<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cv_educations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cv_profile_id')->constrained()->onDelete('cascade');
            
            $table->string('titulo');
            $table->string('institucion');
            $table->string('ubicacion')->nullable();
            $table->date('fecha_inicio');
            $table->date('fecha_fin')->nullable();
            $table->boolean('estudiando_actualmente')->default(false);
            $table->text('descripcion')->nullable();
            $table->string('promedio')->nullable();
            $table->integer('orden')->default(0);
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cv_educations');
    }
};