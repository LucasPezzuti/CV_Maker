<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvEducation extends Model
{
    use HasFactory;
    protected $table = 'cv_educations';
    protected $fillable = [
        'cv_profile_id',
        'titulo',
        'institucion',
        'ubicacion',
        'fecha_inicio',
        'fecha_fin',
        'estudiando_actualmente',
        'descripcion',
        'promedio',
        'orden'
    ];

    protected $casts = [
        'fecha_inicio' => 'date',
        'fecha_fin' => 'date',
        'estudiando_actualmente' => 'boolean'
    ];

    public function cvProfile()
    {
        return $this->belongsTo(CvProfile::class);
    }

    public function getPeriodoEstudioAttribute()
    {
        $inicio = $this->fecha_inicio->format('m/Y');
        $fin = $this->estudiando_actualmente ? 'Presente' : $this->fecha_fin->format('m/Y');
        
        return "{$inicio} - {$fin}";
    }
}