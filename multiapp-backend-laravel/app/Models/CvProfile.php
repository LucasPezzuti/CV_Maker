<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvProfile extends Model
{
    use HasFactory;
    protected $table = 'cv_profiles';
    protected $fillable = [
        'user_id',
        'nombre',
        'apellido',
        'email',
        'telefono',
        'direccion',
        'ciudad',
        'codigo_postal',
        'linkedin',
        'github',
        'portfolio',
        'titulo_profesional',
        'resumen_profesional',
        'template',
        'configuracion'
    ];

    protected $casts = [
        'configuracion' => 'array'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function experiences()
    {
        return $this->hasMany(CvExperience::class)->orderBy('orden');
    }

    public function educations()
    {
        return $this->hasMany(CvEducation::class)->orderBy('orden');
    }

    public function skills()
    {
        return $this->hasMany(CvSkill::class)->orderBy('orden');
    }

    public function getNombreCompletoAttribute()
    {
        return $this->nombre . ' ' . $this->apellido;
    }
}