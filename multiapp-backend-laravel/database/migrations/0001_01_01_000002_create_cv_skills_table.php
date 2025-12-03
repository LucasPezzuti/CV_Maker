<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('cv_skills', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cv_profile_id')->constrained()->onDelete('cascade');
            
            $table->string('nombre');
            $table->enum('categoria', ['tecnica', 'blanda', 'idioma', 'certificacion']);
            $table->integer('nivel')->default(1); // 1-5 para nivel de competencia
            $table->string('nivel_texto')->nullable(); // "Básico", "Intermedio", "Avanzado", "Nativo"
            $table->integer('orden')->default(0);
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('cv_skills');
    }
};