<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvSkill extends Model
{
    use HasFactory;
    protected $table = 'cv_skills';
    protected $fillable = [
        'cv_profile_id',
        'nombre',
        'categoria',
        'nivel',
        'nivel_texto',
        'orden'
    ];

    public function cvProfile()
    {
        return $this->belongsTo(CvProfile::class);
    }

    public function getNivelTextoAutomaticoAttribute()
    {
        if ($this->nivel_texto) {
            return $this->nivel_texto;
        }

        switch ($this->nivel) {
            case 1:
                return 'Básico';
            case 2:
                return 'Principiante';
            case 3:
                return 'Intermedio';
            case 4:
                return 'Avanzado';
            case 5:
                return 'Experto';
            default:
                return 'No especificado';
        }
    }

    public function getCategoriaFormateadaAttribute()
    {
        $categorias = [
            'tecnica' => 'Técnica',
            'blanda' => 'Blanda',
            'idioma' => 'Idioma',
            'certificacion' => 'Certificación'
        ];

        return $categorias[$this->categoria] ?? $this->categoria;
    }
}