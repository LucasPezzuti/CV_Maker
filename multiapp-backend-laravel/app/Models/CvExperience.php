<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class CvExperience extends Model
{
    use HasFactory;
    protected $table = 'cv_experiences';
    protected $fillable = [
        'cv_profile_id',
        'puesto',
        'empresa',
        'ubicacion',
        'fecha_inicio',
        'fecha_fin',
        'trabajo_actual',
        'descripcion',
        'logros',
        'orden'
    ];

    protected $casts = [
        'fecha_inicio' => 'date',
        'fecha_fin' => 'date',
        'trabajo_actual' => 'boolean',
        'logros' => 'array'
    ];

    public function cvProfile()
    {
        return $this->belongsTo(CvProfile::class);
    }

    public function getPeriodoTrabajoAttribute()
    {
        $inicio = $this->fecha_inicio->format('m/Y');
        $fin = $this->trabajo_actual ? 'Presente' : $this->fecha_fin->format('m/Y');
        
        return "{$inicio} - {$fin}";
    }

    public function getDuracionAttribute()
    {
        $fechaFin = $this->trabajo_actual ? Carbon::now() : $this->fecha_fin;
        $diferencia = $this->fecha_inicio->diffInMonths($fechaFin);
        
        $años = intval($diferencia / 12);
        $meses = $diferencia % 12;
        
        if ($años > 0 && $meses > 0) {
            return "{$años} año(s) y {$meses} mes(es)";
        } elseif ($años > 0) {
            return "{$años} año(s)";
        } else {
            return "{$meses} mes(es)";
        }
    }
}