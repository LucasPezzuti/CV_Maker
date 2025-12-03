<?php

namespace App\Http\Controllers;

use App\Models\CvProfile;
use App\Models\CvExperience;
use App\Models\CvEducation;
use App\Models\CvSkill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class CvController extends Controller
{
    public function index(Request $request)
    {
        $profile = CvProfile::with(['experiences', 'educations', 'skills'])
            ->where('user_id', $request->user()->id)
            ->first();

        if (!$profile) {
            return response()->json([
                'exists' => false,
                'message' => 'No hay CV guardado'
            ]);
        }

        return response()->json([
            'exists' => true,
            'profile' => $profile
        ]);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nombre' => 'required|string|max:255',
            'apellido' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'telefono' => 'nullable|string|max:20',
            'titulo_profesional' => 'nullable|string|max:255',
            'resumen_profesional' => 'nullable|string',
            'experiences' => 'array',
            'experiences.*.puesto' => 'required|string|max:255',
            'experiences.*.empresa' => 'required|string|max:255',
            'experiences.*.fecha_inicio' => 'required|date',
            'experiences.*.fecha_fin' => 'nullable|date|after:experiences.*.fecha_inicio',
            'educations' => 'array',
            'educations.*.titulo' => 'required|string|max:255',
            'educations.*.institucion' => 'required|string|max:255',
            'educations.*.fecha_inicio' => 'required|date',
            'skills' => 'array',
            'skills.*.nombre' => 'required|string|max:255',
            'skills.*.categoria' => 'required|in:tecnica,blanda,idioma,certificacion',
            'skills.*.nivel' => 'required|integer|min:1|max:5'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            DB::beginTransaction();

            // Buscar o crear perfil
            $profile = CvProfile::updateOrCreate(
                ['user_id' => $request->user()->id],
                $request->only([
                    'nombre', 'apellido', 'email', 'telefono', 'direccion',
                    'ciudad', 'codigo_postal', 'linkedin', 'github', 'portfolio',
                    'titulo_profesional', 'resumen_profesional', 'template'
                ])
            );

            // Limpiar datos existentes
            $profile->experiences()->delete();
            $profile->educations()->delete();
            $profile->skills()->delete();

            // Guardar experiencias
            if ($request->has('experiences')) {
                foreach ($request->experiences as $index => $experience) {
                    $profile->experiences()->create([
                        ...$experience,
                        'orden' => $index
                    ]);
                }
            }

            // Guardar educación
            if ($request->has('educations')) {
                foreach ($request->educations as $index => $education) {
                    $profile->educations()->create([
                        ...$education,
                        'orden' => $index
                    ]);
                }
            }

            // Guardar habilidades
            if ($request->has('skills')) {
                foreach ($request->skills as $index => $skill) {
                    $profile->skills()->create([
                        ...$skill,
                        'orden' => $index
                    ]);
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'CV guardado exitosamente',
                'profile' => $profile->load(['experiences', 'educations', 'skills'])
            ]);

        } catch (\Exception $e) {
            DB::rollback();
            
            return response()->json([
                'success' => false,
                'message' => 'Error al guardar el CV: ' . $e->getMessage()
            ], 500);
        }
    }

    public function generatePdf(Request $request)
    {
        $profile = CvProfile::with(['experiences', 'educations', 'skills'])
            ->where('user_id', $request->user()->id)
            ->first();

        if (!$profile) {
            return response()->json([
                'success' => false,
                'message' => 'No hay CV para generar'
            ], 404);
        }

        // Aquí integrarías una librería como DomPDF o Puppeteer
        // Por ahora retornamos los datos para generar en frontend

        return response()->json([
            'success' => true,
            'profile' => $profile,
            'download_url' => route('cv.download', $profile->id)
        ]);
    }
}