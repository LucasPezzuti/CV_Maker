<template>
  <q-page class="q-pa-md">
    <div class="q-gutter-md cv-form-container">
      <!-- Header -->
      <div class="text-center q-mb-lg">
        <div class="text-h4 text-weight-bold q-mb-sm">
          <q-icon name="description" class="q-mr-sm" color="primary" />
          Generador de CV Profesional
        </div>
        <div class="text-subtitle1 text-grey-7">
          Crea un CV optimizado para sistemas ATS
        </div>
      </div>

      <!-- Información Personal -->
      <q-card class="section-card">
        <q-card-section>
          <div class="text-h6 section-title">
            <q-icon name="person" class="q-mr-sm" color="primary" />
            Información Personal
          </div>
          
          <div class="row q-gutter-md">
            <div class="col-12 col-md-6">
              <q-input
                filled
                v-model="perfil.nombre"
                label="Nombre *"
                :error="errors.nombre"
                :error-message="errors.nombre"
              />
            </div>
            <div class="col-12 col-md-6">
              <q-input
                filled
                v-model="perfil.apellido"
                label="Apellido *"
                :error="errors.apellido"
                :error-message="errors.apellido"
              />
            </div>
          </div>

          <div class="row q-gutter-md q-mt-sm">
            <div class="col-12 col-md-6">
              <q-input
                filled
                v-model="perfil.email"
                label="Email *"
                type="email"
                :error="errors.email"
                :error-message="errors.email"
              />
            </div>
            <div class="col-12 col-md-6">
              <q-input
                filled
                v-model="perfil.telefono"
                label="Teléfono"
                mask="(###) ###-####"
              />
            </div>
          </div>

          <div class="row q-gutter-md q-mt-sm">
            <div class="col-12 col-md-4">
              <q-input
                filled
                v-model="perfil.ciudad"
                label="Ciudad"
              />
            </div>
            <div class="col-12 col-md-4">
              <q-input
                filled
                v-model="perfil.direccion"
                label="Dirección"
              />
            </div>
            <div class="col-12 col-md-4">
              <q-input
                filled
                v-model="perfil.codigo_postal"
                label="Código Postal"
              />
            </div>
          </div>

          <div class="row q-gutter-md q-mt-sm">
            <div class="col-12 col-md-4">
              <q-input
                filled
                v-model="perfil.linkedin"
                label="LinkedIn"
                placeholder="https://linkedin.com/in/usuario"
                prefix="🔗"
              />
            </div>
            <div class="col-12 col-md-4">
              <q-input
                filled
                v-model="perfil.github"
                label="GitHub"
                placeholder="https://github.com/usuario"
                prefix="📂"
              />
            </div>
            <div class="col-12 col-md-4">
              <q-input
                filled
                v-model="perfil.portfolio"
                label="Portfolio"
                placeholder="https://miportfolio.com"
                prefix="🌐"
              />
            </div>
          </div>
        </q-card-section>
      </q-card>

      <!-- Perfil Profesional -->
      <q-card class="section-card">
        <q-card-section>
          <div class="text-h6 section-title">
            <q-icon name="work" class="q-mr-sm" color="primary" />
            Perfil Profesional
          </div>
          
          <q-input
            filled
            v-model="perfil.titulo_profesional"
            label="Título Profesional"
            placeholder="Ej: Desarrollador Full Stack Senior"
            class="q-mb-md"
          />
          
          <q-input
            filled
            v-model="perfil.resumen_profesional"
            label="Resumen Profesional"
            type="textarea"
            rows="4"
            placeholder="Describe tu experiencia, fortalezas y objetivos profesionales en 2-3 líneas..."
            counter
            maxlength="500"
          />
        </q-card-section>
      </q-card>

      <!-- Experiencia Laboral - NUEVA SECCIÓN CORREGIDA -->
      <q-card class="section-card">
        <q-card-section>
          <div class="row items-center justify-between q-mb-md">
            <div class="text-h6 section-title">
              <q-icon name="business_center" class="q-mr-sm" color="primary" />
              Experiencia Laboral
            </div>
            <q-btn
              flat
              round
              icon="add"
              color="primary"
              @click="agregarExperiencia"
              size="sm"
            />
          </div>

          <div v-if="!experiencias.length" class="text-center text-grey-6 q-pa-lg">
            <q-icon name="work_off" size="48px" class="q-mb-sm" />
            <div>No hay experiencias laborales agregadas</div>
            <q-btn 
              flat 
              color="primary" 
              @click="agregarExperiencia"
              class="q-mt-sm"
            >
              Agregar primera experiencia
            </q-btn>
          </div>

          <div v-for="(exp, index) in experiencias" :key="index" class="experience-item">
            <div class="row q-gutter-md">
              <div class="col-12 col-md-6">
                <q-input
                  filled
                  v-model="exp.puesto"
                  label="Puesto *"
                  :error="errors[`experiences.${index}.puesto`]"
                  placeholder="Ej: Desarrollador Frontend"
                />
              </div>
              <div class="col-12 col-md-6">
                <q-input
                  filled
                  v-model="exp.empresa"
                  label="Empresa *"
                  :error="errors[`experiences.${index}.empresa`]"
                  placeholder="Ej: Google Inc."
                />
              </div>
            </div>

            <div class="row q-gutter-md q-mt-sm">
              <div class="col-12 col-md-6">
                <q-input
                  filled
                  v-model="exp.ubicacion"
                  label="Ubicación"
                  placeholder="Ej: Ciudad, País"
                />
              </div>
              <div class="col-12 col-md-3">
                <q-input
                  filled
                  v-model="exp.fecha_inicio"
                  label="Fecha Inicio *"
                  mask="####-##-##"
                >
                  <template v-slot:append>
                    <q-icon name="event" class="cursor-pointer">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-date
                          v-model="exp.fecha_inicio"
                          mask="YYYY-MM-DD"
                        >
                          <div class="row items-center justify-end">
                            <q-btn v-close-popup label="Cerrar" color="primary" flat />
                          </div>
                        </q-date>
                      </q-popup-proxy>
                    </q-icon>
                  </template>
                </q-input>
              </div>
              <div class="col-12 col-md-3">
                <q-input
                  filled
                  v-model="exp.fecha_fin"
                  label="Fecha Fin"
                  mask="####-##-##"
                  :disable="exp.trabajo_actual"
                >
                  <template v-slot:append>
                    <q-icon name="event" class="cursor-pointer" v-if="!exp.trabajo_actual">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-date
                          v-model="exp.fecha_fin"
                          mask="YYYY-MM-DD"
                        >
                          <div class="row items-center justify-end">
                            <q-btn v-close-popup label="Cerrar" color="primary" flat />
                          </div>
                        </q-date>
                      </q-popup-proxy>
                    </q-icon>
                  </template>
                </q-input>
              </div>
            </div>

            <div class="row q-gutter-md q-mt-sm">
              <div class="col-12 col-md-2">
                <q-checkbox
                  v-model="exp.trabajo_actual"
                  label="Trabajo actual"
                  @update:model-value="val => { if (val) exp.fecha_fin = null }"
                />
              </div>
            </div>

            <div class="row q-gutter-md q-mt-sm">
              <div class="col-12">
                <q-input
                  filled
                  v-model="exp.descripcion"
                  label="Descripción de responsabilidades y logros"
                  type="textarea"
                  rows="3"
                  placeholder="Describe tus responsabilidades, logros y contribuciones en este puesto..."
                  counter
                  maxlength="1000"
                />
              </div>
            </div>

            <div class="row items-center q-mt-sm">
              <q-btn
                flat
                round
                icon="delete"
                color="negative"
                size="sm"
                @click="eliminarExperiencia(index)"
              />
            </div>

            <q-separator class="q-mt-md" v-if="index < experiencias.length - 1" />
          </div>
        </q-card-section>
      </q-card>

      <!-- Educación - SECCIÓN CORREGIDA (antes mal etiquetada como Experiencia Laboral) -->
      <q-card class="section-card">
        <q-card-section>
          <div class="row items-center justify-between q-mb-md">
            <div class="text-h6 section-title">
              <q-icon name="school" class="q-mr-sm" color="primary" />
              Educación
            </div>
            <q-btn
              flat
              round
              icon="add"
              color="primary"
              @click="agregarEducacion"
              size="sm"
            />
          </div>

          <div v-if="!educaciones.length" class="text-center text-grey-6 q-pa-lg">
            <q-icon name="school_off" size="48px" class="q-mb-sm" />
            <div>No hay educación agregada</div>
            <q-btn 
              flat 
              color="primary" 
              @click="agregarEducacion"
              class="q-mt-sm"
            >
              Agregar primera educación
            </q-btn>
          </div>

          <div v-for="(edu, index) in educaciones" :key="index" class="education-item">
            <div class="row q-gutter-md">
              <div class="col-12 col-md-6">
                <q-input
                  filled
                  v-model="edu.titulo"
                  label="Título/Carrera *"
                  :error="errors[`educations.${index}.titulo`]"
                />
              </div>
              <div class="col-12 col-md-6">
                <q-input
                  filled
                  v-model="edu.institucion"
                  label="Institución *"
                  :error="errors[`educations.${index}.institucion`]"
                />
              </div>
            </div>

            <div class="row q-gutter-md q-mt-sm">
              <div class="col-12 col-md-4">
                <q-input
                  filled
                  v-model="edu.ubicacion"
                  label="Ubicación"
                />
              </div>
              <div class="col-12 col-md-3">
                <q-input
                  filled
                  v-model="edu.fecha_inicio"
                  label="Fecha Inicio *"
                  mask="####-##-##"
                >
                  <template v-slot:append>
                    <q-icon name="event" class="cursor-pointer">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-date
                          v-model="edu.fecha_inicio"
                          mask="YYYY-MM-DD"
                        >
                          <div class="row items-center justify-end">
                            <q-btn v-close-popup label="Cerrar" color="primary" flat />
                          </div>
                        </q-date>
                      </q-popup-proxy>
                    </q-icon>
                  </template>
                </q-input>
              </div>
              <div class="col-12 col-md-3">
                <q-input
                  filled
                  v-model="edu.fecha_fin"
                  label="Fecha Fin"
                  mask="####-##-##"
                  :disable="edu.estudiando_actualmente"
                >
                  <template v-slot:append>
                    <q-icon name="event" class="cursor-pointer" v-if="!edu.estudiando_actualmente">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-date
                          v-model="edu.fecha_fin"
                          mask="YYYY-MM-DD"
                        >
                          <div class="row items-center justify-end">
                            <q-btn v-close-popup label="Cerrar" color="primary" flat />
                          </div>
                        </q-date>
                      </q-popup-proxy>
                    </q-icon>
                  </template>
                </q-input>
              </div>
              <div class="col-12 col-md-2">
                <q-checkbox
                  v-model="edu.estudiando_actualmente"
                  label="Actual"
                  @update:model-value="val => { if (val) edu.fecha_fin = null }"
                />
              </div>
            </div>

            <div class="row q-gutter-md q-mt-sm">
              <div class="col-12 col-md-8">
                <q-input
                  filled
                  v-model="edu.descripcion"
                  label="Descripción"
                  placeholder="Menciona especialización, tesis, logros académicos..."
                />
              </div>
              <div class="col-12 col-md-4">
                <q-input
                  filled
                  v-model="edu.promedio"
                  label="Promedio/GPA"
                  placeholder="Ej: 8.5, 3.8/4.0"
                />
              </div>
            </div>

            <div class="row items-center q-mt-sm">
              <q-btn
                flat
                round
                icon="delete"
                color="negative"
                size="sm"
                @click="eliminarEducacion(index)"
              />
            </div>

            <q-separator class="q-mt-md" v-if="index < educaciones.length - 1" />
          </div>
        </q-card-section>
      </q-card>

      <!-- Habilidades -->
      <q-card class="section-card">
        <q-card-section>
          <div class="row items-center justify-between q-mb-md">
            <div class="text-h6 section-title">
              <q-icon name="psychology" class="q-mr-sm" color="primary" />
              Habilidades y Competencias
            </div>
            <q-btn
              flat
              round
              icon="add"
              color="primary"
              @click="agregarHabilidad"
              size="sm"
            />
          </div>

          <div v-if="!habilidades.length" class="text-center text-grey-6 q-pa-lg">
            <q-icon name="build_off" size="48px" class="q-mb-sm" />
            <div>No hay habilidades agregadas</div>
            <q-btn 
              flat 
              color="primary" 
              @click="agregarHabilidad"
              class="q-mt-sm"
            >
              Agregar primera habilidad
            </q-btn>
          </div>

          <div class="skills-grid">
            <div v-for="(skill, index) in habilidades" :key="index" class="skill-item">
              <div class="row q-gutter-sm items-end">
                <div class="col-4">
                  <q-input
                    filled
                    v-model="skill.nombre"
                    label="Habilidad *"
                    dense
                    :error="errors[`skills.${index}.nombre`]"
                  />
                </div>
                <div class="col-3">
                  <q-select
                    filled
                    v-model="skill.categoria"
                    :options="categoriasHabilidades"
                    option-label="label"
                    option-value="value"
                    label="Categoría *"
                    dense
                    emit-value
                    map-options
                  />
                </div>
                <div class="col-2">
                  <q-select
                    filled
                    v-model="skill.nivel"
                    :options="nivelesHabilidad"
                    option-label="label"
                    option-value="value"
                    label="Nivel *"
                    dense
                    emit-value
                    map-options
                  />
                </div>
                <div class="col-2">
                  <q-input
                    filled
                    v-model="skill.nivel_texto"
                    label="Nivel Texto"
                    placeholder="Ej: Nativo"
                    dense
                  />
                </div>
                <div class="col-1">
                  <q-btn
                    flat
                    round
                    icon="delete"
                    color="negative"
                    size="sm"
                    @click="eliminarHabilidad(index)"
                    dense
                  />
                </div>
              </div>
            </div>
          </div>
        </q-card-section>
      </q-card>

      <!-- Botones de acción -->
      <q-card class="action-buttons">
        <q-card-section>
          <div class="row q-gutter-md justify-center">
            <q-btn
              class="btn-gradient"
              label="Vista Previa"
              icon="preview"
              @click="mostrarVistaPrevia"
              :loading="previewing"
              size="lg"
            />
            
            <q-btn
              color="positive"
              label="Guardar CV"
              icon="save"
              @click="guardarCV"
              :loading="guardando"
              size="lg"
            />
            
            <q-btn
              color="secondary"
              label="Descargar PDF"
              icon="download"
              @click="descargarPDF"
              :loading="descargando"
              :disable="!perfilGuardado"
              size="lg"
            />
          </div>
        </q-card-section>
      </q-card>

      <!-- Vista previa modal -->
      <q-dialog v-model="vistaPrevia" maximized>
        <q-card>
          <q-card-section class="row items-center q-pb-none">
            <div class="text-h6">Vista previa del CV</div>
            <q-space />
            <q-btn icon="close" flat round dense v-close-popup />
          </q-card-section>
          
          <q-card-section>
            <div class="cv-preview">
              <div class="cv-header">
                <h1>{{ perfil.nombre }} {{ perfil.apellido }}</h1>
                <h2>{{ perfil.titulo_profesional }}</h2>
                <div class="contact-info">
                  <span v-if="perfil.email">📧 {{ perfil.email }}</span>
                  <span v-if="perfil.telefono">📞 {{ perfil.telefono }}</span>
                  <span v-if="perfil.ciudad">📍 {{ perfil.ciudad }}</span>
                </div>
                <div class="links" v-if="perfil.linkedin || perfil.github || perfil.portfolio">
                  <a v-if="perfil.linkedin" :href="perfil.linkedin" target="_blank">LinkedIn</a>
                  <a v-if="perfil.github" :href="perfil.github" target="_blank">GitHub</a>
                  <a v-if="perfil.portfolio" :href="perfil.portfolio" target="_blank">Portfolio</a>
                </div>
              </div>
              
              <div class="cv-section" v-if="perfil.resumen_profesional">
                <h3>Perfil Profesional</h3>
                <p>{{ perfil.resumen_profesional }}</p>
              </div>
              
              <div class="cv-section" v-if="experiencias.length">
                <h3>Experiencia Laboral</h3>
                <div v-for="exp in experiencias" :key="exp.puesto" class="cv-item">
                  <h4>{{ exp.puesto }} - {{ exp.empresa }}</h4>
                  <div class="date-location">
                    {{ formatearPeriodo(exp.fecha_inicio, exp.fecha_fin, exp.trabajo_actual) }}
                    <span v-if="exp.ubicacion"> | {{ exp.ubicacion }}</span>
                  </div>
                  <p v-if="exp.descripcion">{{ exp.descripcion }}</p>
                </div>
              </div>
              
              <div class="cv-section" v-if="educaciones.length">
                <h3>Educación</h3>
                <div v-for="edu in educaciones" :key="edu.titulo" class="cv-item">
                  <h4>{{ edu.titulo }} - {{ edu.institucion }}</h4>
                  <div class="date-location">
                    {{ formatearPeriodo(edu.fecha_inicio, edu.fecha_fin, edu.estudiando_actualmente) }}
                    <span v-if="edu.ubicacion"> | {{ edu.ubicacion }}</span>
                    <span v-if="edu.promedio"> | Promedio: {{ edu.promedio }}</span>
                  </div>
                  <p v-if="edu.descripcion">{{ edu.descripcion }}</p>
                </div>
              </div>
              
              <div class="cv-section" v-if="habilidades.length">
                <h3>Habilidades</h3>
                <div v-for="categoria in habilidadesPorCategoria" :key="categoria.nombre" class="skills-category">
                  <h4>{{ categoria.nombre }}</h4>
                  <div class="skills-list">
                    <span v-for="skill in categoria.skills" :key="skill.nombre" class="skill-tag">
                      {{ skill.nombre }} 
                      <small v-if="skill.nivel_texto">({{ skill.nivel_texto }})</small>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </q-card-section>
        </q-card>
      </q-dialog>
    </div>

    <!-- Loading global -->
    <q-inner-loading :showing="guardando || cargando">
      <q-spinner-gears size="50px" color="primary" />
      <div class="q-mt-md text-center">
        {{ guardando ? 'Guardando CV...' : 'Cargando datos...' }}
      </div>
    </q-inner-loading>
  </q-page>
</template>

<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth'
})

import { useAuthStore } from '~/stores/auth'
const auth = useAuthStore()

import { ref, computed, onMounted } from 'vue'
import { useQuasar, date } from 'quasar'
import axios from 'axios'

const $q = useQuasar()

// Estados principales
const cargando = ref(false)
const guardando = ref(false)
const previewing = ref(false)
const descargando = ref(false)
const vistaPrevia = ref(false)
const perfilGuardado = ref(false)
const errors = ref({})

// Datos del perfil
const perfil = ref({
  nombre: '',
  apellido: '',
  email: '',
  telefono: '',
  direccion: '',
  ciudad: '',
  codigo_postal: '',
  linkedin: '',
  github: '',
  portfolio: '',
  titulo_profesional: '',
  resumen_profesional: '',
  template: 'modern'
})

// Arrays para secciones dinámicas
const experiencias = ref([])
const educaciones = ref([])
const habilidades = ref([])

// Opciones para selects
const categoriasHabilidades = [
  { label: 'Técnica', value: 'tecnica' },
  { label: 'Blanda', value: 'blanda' },
  { label: 'Idioma', value: 'idioma' },
  { label: 'Certificación', value: 'certificacion' }
]

const nivelesHabilidad = [
  { label: '1 - Básico', value: 1 },
  { label: '2 - Principiante', value: 2 },
  { label: '3 - Intermedio', value: 3 },
  { label: '4 - Avanzado', value: 4 },
  { label: '5 - Experto', value: 5 }
]

// Computed para agrupar habilidades por categoría
const habilidadesPorCategoria = computed(() => {
  const grupos = {}
  habilidades.value.forEach(skill => {
    const categoria = categoriasHabilidades.find(cat => cat.value === skill.categoria)?.label || skill.categoria
    if (!grupos[categoria]) {
      grupos[categoria] = { nombre: categoria, skills: [] }
    }
    grupos[categoria].skills.push(skill)
  })
  return Object.values(grupos)
})

// Funciones para agregar elementos
function agregarExperiencia() {
  experiencias.value.push({
    puesto: '',
    empresa: '',
    ubicacion: '',
    fecha_inicio: '',
    fecha_fin: '',
    trabajo_actual: false,
    descripcion: '',
    logros: []
  })
}

function agregarEducacion() {
  educaciones.value.push({
    titulo: '',
    institucion: '',
    ubicacion: '',
    fecha_inicio: '',
    fecha_fin: '',
    estudiando_actualmente: false,
    descripcion: '',
    promedio: ''
  })
}

function agregarHabilidad() {
  habilidades.value.push({
    nombre: '',
    categoria: 'tecnica',
    nivel: 3,
    nivel_texto: '',
    orden: habilidades.value.length
  })
}

// Funciones para eliminar elementos
function eliminarExperiencia(index) {
  experiencias.value.splice(index, 1)
}

function eliminarEducacion(index) {
  educaciones.value.splice(index, 1)
}

function eliminarHabilidad(index) {
  habilidades.value.splice(index, 1)
}

// Formatear período de fechas
function formatearPeriodo(inicio, fin, esActual) {
  if (!inicio) return ''
  
  const fechaInicio = new Date(inicio).toLocaleDateString('es-ES', { 
    month: 'short', 
    year: 'numeric' 
  })
  
  if (esActual) {
    return `${fechaInicio} - Presente`
  }
  
  if (!fin) {
    return fechaInicio
  }
  
  const fechaFin = new Date(fin).toLocaleDateString('es-ES', { 
    month: 'short', 
    year: 'numeric' 
  })
  
  return `${fechaInicio} - ${fechaFin}`
}

// Cargar datos existentes
async function cargarDatos() {
  cargando.value = true
  
  try {
    const response = await axios.get('http://localhost:8000/api/cv', {
      headers: {
        Authorization: `Bearer ${auth.token}`
      }
    })
    
    if (response.data.exists) {
      const data = response.data.profile
      
      // Cargar datos del perfil
      Object.keys(perfil.value).forEach(key => {
        if (data[key] !== undefined) {
          perfil.value[key] = data[key]
        }
      })
      
      // Cargar experiencias
      experiencias.value = data.experiences || []
      
      // Cargar educación
      educaciones.value = data.educations || []
      
      // Cargar habilidades
      habilidades.value = data.skills || []
      
      perfilGuardado.value = true
      
      $q.notify({
        type: 'positive',
        message: 'CV cargado exitosamente',
        position: 'top'
      })
    } else {
      // Si no existe CV, agregar elementos básicos
      agregarExperiencia()
      agregarEducacion()
      agregarHabilidad()
    }
  } catch (error) {
    console.error('Error al cargar CV:', error)
    $q.notify({
      type: 'negative',
      message: 'Error al cargar el CV',
      position: 'top'
    })
    
    // Agregar elementos básicos en caso de error
    agregarExperiencia()
    agregarEducacion()
    agregarHabilidad()
  } finally {
    cargando.value = false
  }
}

// Validar formulario
function validarFormulario() {
  errors.value = {}
  
  // Validar datos básicos
  if (!perfil.value.nombre.trim()) {
    errors.value.nombre = 'El nombre es requerido'
  }
  
  if (!perfil.value.apellido.trim()) {
    errors.value.apellido = 'El apellido es requerido'
  }
  
  if (!perfil.value.email.trim()) {
    errors.value.email = 'El email es requerido'
  } else if (!/\S+@\S+\.\S+/.test(perfil.value.email)) {
    errors.value.email = 'Email inválido'
  }
  
  // Validar experiencias
  experiencias.value.forEach((exp, index) => {
    if (!exp.puesto.trim()) {
      errors.value[`experiences.${index}.puesto`] = 'Puesto requerido'
    }
    if (!exp.empresa.trim()) {
      errors.value[`experiences.${index}.empresa`] = 'Empresa requerida'
    }
  })
  
  // Validar educación
  educaciones.value.forEach((edu, index) => {
    if (!edu.titulo.trim()) {
      errors.value[`educations.${index}.titulo`] = 'Título requerido'
    }
    if (!edu.institucion.trim()) {
      errors.value[`educations.${index}.institucion`] = 'Institución requerida'
    }
  })
  
  // Validar habilidades
  habilidades.value.forEach((skill, index) => {
    if (!skill.nombre.trim()) {
      errors.value[`skills.${index}.nombre`] = 'Nombre de habilidad requerido'
    }
  })
  
  return Object.keys(errors.value).length === 0
}

// Guardar CV
async function guardarCV() {
  if (!validarFormulario()) {
    $q.notify({
      type: 'negative',
      message: 'Por favor corrige los errores en el formulario',
      position: 'top'
    })
    return
  }
  
  guardando.value = true
  
  try {
    const payload = {
      ...perfil.value,
      experiences: experiencias.value,
      educations: educaciones.value,
      skills: habilidades.value
    }
    
    const response = await axios.post('http://localhost:8000/api/cv', payload, {
      headers: {
        Authorization: `Bearer ${auth.token}`,
        'Content-Type': 'application/json'
      }
    })
    
    if (response.data.success) {
      perfilGuardado.value = true
      $q.notify({
        type: 'positive',
        message: 'CV guardado exitosamente',
        position: 'top'
      })
    }
  } catch (error) {
    console.error('Error al guardar CV:', error)
    $q.notify({
      type: 'negative',
      message: error.response?.data?.message || 'Error al guardar el CV',
      position: 'top'
    })
  } finally {
    guardando.value = false
  }
}

// Mostrar vista previa
function mostrarVistaPrevia() {
  if (!validarFormulario()) {
    $q.notify({
      type: 'negative',
      message: 'Por favor completa los campos requeridos',
      position: 'top'
    })
    return
  }
  
  vistaPrevia.value = true
}

// Descargar PDF
async function descargarPDF() {
  if (!perfilGuardado.value) {
    $q.notify({
      type: 'warning',
      message: 'Primero debes guardar el CV',
      position: 'top'
    })
    return
  }
  
  descargando.value = true
  
  try {
    const response = await axios.get('http://localhost:8000/api/cv/generate-pdf', {
      headers: {
        Authorization: `Bearer ${auth.token}`
      },
      responseType: 'blob'
    })
    
    // Crear URL de descarga
    const url = window.URL.createObjectURL(new Blob([response.data]))
    const link = document.createElement('a')
    link.href = url
    link.setAttribute('download', `CV_${perfil.value.nombre}_${perfil.value.apellido}.pdf`)
    document.body.appendChild(link)
    link.click()
    link.remove()
    
    $q.notify({
      type: 'positive',
      message: 'PDF descargado exitosamente',
      position: 'top'
    })
  } catch (error) {
    console.error('Error al descargar PDF:', error)
    $q.notify({
      type: 'negative',
      message: 'Error al generar el PDF',
      position: 'top'
    })
  } finally {
    descargando.value = false
  }
}

// Cargar datos al montar el componente
onMounted(() => {
  cargarDatos()
})
</script>

<style scoped>
.cv-form-container {
  max-width: 1200px;
  margin: 0 auto;
}

.section-card {
  margin-bottom: 24px;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
}

.section-title {
  color: #1976d2;
  font-weight: 600;
  margin-bottom: 16px;
}

.experience-item,
.education-item {
  padding: 16px;
  margin-bottom: 16px;
  background: #f8f9fa;
  border-radius: 8px;
  border-left: 4px solid #1976d2;
}

.skills-grid {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.skill-item {
  padding: 12px;
  background: #f8f9fa;
  border-radius: 8px;
}

.action-buttons {
  position: sticky;
  bottom: 20px;
  z-index: 10;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.15);
}

.btn-gradient {
  background: linear-gradient(135deg, #1976d2 0%, #42a5f5 50%, #90caf9 100%) !important;
  color: white !important;
  border: none;
}

.btn-gradient:hover {
  background: linear-gradient(135deg, #1565c0 0%, #1e88e5 50%, #64b5f6 100%) !important;
}

/* Estilos de vista previa */
.cv-preview {
  max-width: 800px;
  margin: 0 auto;
  background: white;
  padding: 40px;
  font-family: 'Arial', sans-serif;
  line-height: 1.6;
}

.cv-header {
  text-align: center;
  border-bottom: 2px solid #1976d2;
  padding-bottom: 20px;
  margin-bottom: 30px;
}

.cv-header h1 {
  font-size: 2.5em;
  margin: 0;
  color: #1976d2;
  font-weight: bold;
}

.cv-header h2 {
  font-size: 1.3em;
  margin: 5px 0 15px 0;
  color: #666;
  font-weight: normal;
}

.contact-info {
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-wrap: wrap;
  margin-bottom: 10px;
  font-size: 0.9em;
}

.links {
  display: flex;
  justify-content: center;
  gap: 15px;
}

.links a {
  color: #1976d2;
  text-decoration: none;
  font-weight: 500;
}

.cv-section {
  margin-bottom: 30px;
}

.cv-section h3 {
  color: #1976d2;
  font-size: 1.3em;
  font-weight: bold;
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 5px;
  margin-bottom: 15px;
}

.cv-item {
  margin-bottom: 20px;
}

.cv-item h4 {
  color: #333;
  font-size: 1.1em;
  font-weight: bold;
  margin: 0 0 5px 0;
}

.date-location {
  color: #666;
  font-size: 0.9em;
  margin-bottom: 8px;
}

.cv-item p {
  margin: 0;
  color: #555;
  text-align: justify;
}

.skills-category {
  margin-bottom: 15px;
}

.skills-category h4 {
  color: #1976d2;
  font-size: 1em;
  margin: 0 0 8px 0;
  font-weight: 600;
}

.skills-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.skill-tag {
  background: #e3f2fd;
  color: #1976d2;
  padding: 4px 12px;
  border-radius: 15px;
  font-size: 0.85em;
  font-weight: 500;
}

@media (max-width: 768px) {
  .cv-preview {
    padding: 20px;
  }
  
  .contact-info {
    flex-direction: column;
    gap: 10px;
  }
  
  .cv-header h1 {
    font-size: 2em;
  }
}
</style>