<template>
  <q-page class="q-pa-md">
    <div class="q-gutter-md">

      
      <!-- Banner informativo -->
      <q-banner class="banner-violeta">
        Genera rutinas personalizadas de ejercicio y alimentación basadas en tu perfil
      </q-banner>

            <!-- Mensaje de ayuda cuando no hay rutinas -->
      <q-card v-if="!rutinaEjercicio && !planComidas && perfilCargado" class="q-mt-md bg-blue-1">
        <q-card-section class="text-center">
          <q-icon name="info" size="48px" color="blue-6" class="q-mb-md" />
          <div class="text-h6 text-blue-8 q-mb-sm">¡Comienza tu transformación!</div>
          <div class="text-body2 text-blue-7">
            Usa los botones de arriba para generar rutinas personalizadas basadas en tu perfil.
            <br />
            La IA creará programas específicos para tus objetivos y características físicas.
          </div>
        </q-card-section>
      </q-card>

      <!-- Tarjetas de generación -->
      <div class="row q-gutter-md" style="justify-content:center">
        <!-- Tarjeta Rutina de Ejercicio -->
        <div class="col-12 col-md-6">
          <q-card class="full-height">
            <q-card-section class="text-center">
              <q-icon name="fitness_center" size="48px" color="deep-purple-5" class="q-mb-md" />
              <div class="text-h6 q-mb-sm">Rutina de Ejercicio</div>
              <div class="text-body2 text-grey-6 q-mb-md">
                Genera una rutina semanal personalizada según tu peso, edad y objetivos
              </div>
              
              <q-btn
                class="btn-gradient full-width"
                label="Generar Rutina de Ejercicio"
                icon="fitness_center"
                :loading="generandoEjercicio"
                @click="generarRutinaEjercicio"
                :disable="!perfilCargado"
              />
              
              <div v-if="!perfilCargado" class="text-caption text-orange q-mt-sm">
                Cargando datos del perfil...
              </div>
            </q-card-section>
          </q-card>
        </div>

        <!-- Tarjeta Plan de Comidas -->
        <div class="col-12 col-md-6">
          <q-card class="full-height">
            <q-card-section class="text-center">
              <q-icon name="restaurant_menu" size="48px" color="deep-purple-5" class="q-mb-md" />
              <div class="text-h6 q-mb-sm">Plan de Comidas</div>
              <div class="text-body2 text-grey-6 q-mb-md">
                Crea un plan nutricional semanal adaptado a tus necesidades y preferencias
              </div>
              
              <q-btn
                class="btn-gradient full-width"
                label="Generar Plan de Comidas"
                icon="restaurant_menu"
                :loading="generandoComidas"
                @click="generarPlanComidas"
                :disable="!perfilCargado"
              />
              
              <div v-if="!perfilCargado" class="text-caption text-orange q-mt-sm">
                Cargando datos del perfil...
              </div>
            </q-card-section>
          </q-card>
        </div>
      </div>

      <!-- Rutina de Ejercicio Generada -->
      <q-card v-if="rutinaEjercicio" class="q-mt-md">
        <q-card-section>
          <div class="row items-center justify-between q-mb-md">
            <div class="text-h6">
              <q-icon name="fitness_center" class="q-mr-sm" color="deep-purple-5" />
              Tu Rutina Semanal de Ejercicio
            </div>
            <q-btn
              flat
              round
              icon="refresh"
              color="primary"
              size="sm"
              :loading="generandoEjercicio"
              @click="generarRutinaEjercicio"
              v-tooltip="'Generar nueva rutina'"
            />
          </div>
          
          <q-banner class="bg-purple-1 rounded-borders">
            <template v-slot:avatar>
              <q-icon name="fitness_center" color="primary" />
            </template>
            <div class="rutina-texto" v-html="rutinaEjercicio"></div>
          </q-banner>

          <div class="q-mt-md text-center">
            <q-btn
              flat
              color="primary"
              icon="download"
              label="Descargar Rutina"
              @click="descargarRutina('ejercicio')"
            />
          </div>
        </q-card-section>
      </q-card>

      <!-- Plan de Comidas Generado -->
      <q-card v-if="planComidas" class="q-mt-md">
        <q-card-section>
          <div class="row items-center justify-between q-mb-md">
            <div class="text-h6">
              <q-icon name="restaurant_menu" class="q-mr-sm" color="deep-purple-5" />
              Tu Plan Semanal de Comidas
            </div>
            <q-btn
              flat
              round
              icon="refresh"
              color="primary"
              size="sm"
              :loading="generandoComidas"
              @click="generarPlanComidas"
              v-tooltip="'Generar nuevo plan'"
            />
          </div>
          
          <q-banner class="bg-green-1 rounded-borders">
            <template v-slot:avatar>
              <q-icon name="restaurant_menu" color="primary" />
            </template>
            <div class="plan-texto" v-html="planComidas"></div>
          </q-banner>

          <div class="q-mt-md text-center">
            <q-btn
              flat
              color="primary"
              icon="download"
              label="Descargar Plan"
              @click="descargarRutina('comidas')"
            />
          </div>
        </q-card-section>
      </q-card>

    </div>

    <!-- Loader global -->
    <q-inner-loading :showing="cargandoPerfil">
      <q-spinner-gears size="50px" color="primary" />
      <div class="q-mt-md text-center">Cargando tu perfil...</div>
    </q-inner-loading>
  </q-page>
</template>

<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth' // Protege la ruta
})

import { useAuthStore } from '~/stores/auth'
const auth = useAuthStore()

import { ref, computed, onMounted } from 'vue'
import { useQuasar } from 'quasar'
import axios from 'axios'

const $q = useQuasar()

// Estados reactivos
const perfil = ref(null)
const cargandoPerfil = ref(false)
const generandoEjercicio = ref(false)
const generandoComidas = ref(false)
const rutinaEjercicio = ref('')
const planComidas = ref('')

// Computed
const perfilCargado = computed(() => perfil.value !== null && !cargandoPerfil.value)

// Cargar perfil del usuario
async function cargarPerfil() {
  cargandoPerfil.value = true
  try {
    const response = await axios.get('http://localhost:8000/api/profile', {
      headers: {
        Authorization: `Bearer ${auth.token}`
      }
    })
    perfil.value = response.data
  } catch (error) {
    console.error('Error al cargar perfil:', error)
    $q.notify({
      type: 'negative',
      message: 'Error al cargar tu perfil. Verifica que tengas datos registrados.'
    })
  } finally {
    cargandoPerfil.value = false
  }
}

// Generar rutina de ejercicio con IA
async function generarRutinaEjercicio() {
  if (!perfil.value || generandoEjercicio.value) return
  
  generandoEjercicio.value = true
  
  try {
    // Construir información del usuario
    const edad = perfil.value.edad || 33
    const peso = perfil.value.peso || 145
    const altura = perfil.value.altura || 186
    const objetivo = perfil.value.objetivo || 'bajar peso'
    const genero = perfil.value.genero || 'masculino'
    const nivelActividad = perfil.value.nivel_actividad || 'principiante'
    
    const prompt = `Como entrenador personal experto, crea una rutina semanal de ejercicio detallada para:
- Edad: ${edad} años
- Peso: ${peso} kg  
- Altura: ${altura} cm
- Género: ${genero}
- Objetivo: ${objetivo}
- Nivel: ${nivelActividad}

Incluye:
1. **Planificación Semanal** (7 días con actividades específicas)
2. **Ejercicios Detallados** (series, repeticiones, descansos)
3. **Calentamiento y Estiramiento**
4. **Consejos de Progresión**
5. **Recomendaciones de Recuperación**

Formato con días numerados, usa **negritas** para títulos importantes. Máximo 400 palabras, específico y práctico.`

    const response = await axios.post('https://openrouter.ai/api/v1/chat/completions', {
      model: 'mistralai/mistral-small-3.2-24b-instruct:free',
      messages: [
        {
          role: 'system',
          content: 'Eres un entrenador personal certificado con 10+ años de experiencia. Creas rutinas personalizadas, seguras y efectivas. Responde en español con formato claro y estructurado. Ten en cuenta especialmente si la persona sufre de obesidad, que no se lastime ejercitando.'
        },
        { role: 'user', content: prompt }
      ],
      max_tokens: 1500,
      temperature: 0.7
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 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'
      }
    })
    
    let rutinaTexto = response.data.choices?.[0]?.message?.content || ''
    
    // Procesar el texto para mejor visualización
    rutinaTexto = rutinaTexto.trim()
    
    // Reemplazar **texto** por <strong>texto</strong>
    rutinaTexto = rutinaTexto.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    
    // Mejorar formato con saltos de línea
    rutinaTexto = rutinaTexto.replace(/(\d+\.)\s/g, '<br><strong>$1</strong> ')
    rutinaTexto = rutinaTexto.replace(/Día\s*(\d+)/g, '<br><strong>Día $1</strong>')
    
    rutinaEjercicio.value = rutinaTexto
    
    $q.notify({
      type: 'positive',
      message: '¡Rutina de ejercicio generada con éxito!'
    })
    
  } catch (error) {
    console.error('Error al generar rutina:', error)
    $q.notify({
      type: 'negative',
      message: 'Error al generar la rutina. Intenta nuevamente.'
    })
  } finally {
    generandoEjercicio.value = false
  }
}

// Generar plan de comidas con IA
async function generarPlanComidas() {
  if (!perfil.value || generandoComidas.value) return
  
  generandoComidas.value = true
  
  try {
    const edad = perfil.value.edad || 33
    const peso = perfil.value.peso || 145
    const altura = perfil.value.altura || 186
    const objetivo = perfil.value.objetivo || 'bajar peso'
    const genero = perfil.value.genero || 'masculino'
    const actividad = perfil.value.nivel_actividad || 'ligera'
    
    // Calcular TMB aproximada
    let tmb = genero.toLowerCase() === 'femenino' 
      ? (655 + (9.6 * peso) + (1.8 * altura) - (4.7 * edad))
      : (66 + (13.7 * peso) + (5 * altura) - (6.8 * edad))
    
    const factorActividad = actividad === 'alto' ? 1.7 : actividad === 'moderado' ? 1.5 : 1.3
    const caloriasDiarias = Math.round(tmb * factorActividad)
    
    const prompt = `Como nutricionista certificado, crea un plan semanal de alimentación para:
- Edad: ${edad} años, Peso: ${peso} kg, Altura: ${altura} cm
- Género: ${genero}, Actividad: ${actividad}  
- Objetivo: ${objetivo}
- Calorías estimadas: ${caloriasDiarias} cal/día

Incluye:
1. **Plan Semanal** (Lunes a Domingo)
2. **5 Comidas Diarias** (desayuno, media mañana, almuerzo, merienda, cena)
3. **Distribución de Macronutrientes**
4. **Tips de Hidratación**
5. **Snacks Saludables Opcionales**

Formato claro con días, usa **negritas** para títulos. Comidas específicas y prácticas. Máximo 450 palabras.`

    const response = await axios.post('https://openrouter.ai/api/v1/chat/completions', {
      model: 'mistralai/mistral-small-3.2-24b-instruct:free',
      messages: [
        {
          role: 'system',
          content: 'Eres un nutricionista clínico especializado en planes alimentarios personalizados. Creas dietas equilibradas, variadas y sostenibles. Responde en español con formato estructurado. En lo posible que sirvan para reducir peso lo mas rapido posible. Hacelo pensando en comidas y cosas que se encuentran en Argentina y que no sean exageradamente caras, por ejemplo no me ofrezcas salmón.'
        },
        { role: 'user', content: prompt }
      ],
      max_tokens: 1550,
      temperature: 0.7
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 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'
      }
    })
    
    let planTexto = response.data.choices?.[0]?.message?.content || ''
    
    // Procesar el texto para mejor visualización
    planTexto = planTexto.trim()
    
    // Reemplazar **texto** por <strong>texto</strong>
    planTexto = planTexto.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    
    // Mejorar formato
    planTexto = planTexto.replace(/(Lunes|Martes|Miércoles|Jueves|Viernes|Sábado|Domingo)/g, '<br><strong>$1</strong>')
    planTexto = planTexto.replace(/(Desayuno|Almuerzo|Cena|Merienda):/g, '<br><em>$1:</em>')
    
    planComidas.value = planTexto
    
    $q.notify({
      type: 'positive',
      message: '¡Plan de comidas generado con éxito!'
    })
    
  } catch (error) {
    console.error('Error al generar plan:', error)
    $q.notify({
      type: 'negative',
      message: 'Error al generar el plan. Intenta nuevamente.'
    })
  } finally {
    generandoComidas.value = false
  }
}

// Descargar rutina como archivo de texto
function descargarRutina(tipo) {
  const contenido = tipo === 'ejercicio' ? rutinaEjercicio.value : planComidas.value
  const titulo = tipo === 'ejercicio' ? 'Rutina_Ejercicio_Semanal' : 'Plan_Comidas_Semanal'
  
  if (!contenido) return
  
  // Remover HTML para el archivo de texto
  const textoLimpio = contenido
    .replace(/<strong>(.*?)<\/strong>/g, '$1')
    .replace(/<em>(.*?)<\/em>/g, '$1')
    .replace(/<br>/g, '\n')
    .replace(/&nbsp;/g, ' ')
  
  const blob = new Blob([textoLimpio], { type: 'text/plain;charset=utf-8' })
  const url = window.URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = `${titulo}_${new Date().toISOString().split('T')[0]}.txt`
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
  window.URL.revokeObjectURL(url)
  
  $q.notify({
    type: 'positive',
    message: `${tipo === 'ejercicio' ? 'Rutina' : 'Plan'} descargado correctamente`
  })
}

// Cargar perfil al montar el componente
onMounted(() => {
  cargarPerfil()
})
</script>

<style scoped>
.q-page {
  max-width: 800px;
  margin: auto;
}

.banner-violeta {
  background: linear-gradient(135deg, #805ad5 0%, #9f7aea 50%, #d6c2ff 100%) !important;
  color: white;
  border-radius: 8px;
  padding: 12px 16px;
}

.btn-gradient {
  background: linear-gradient(135deg, #805ad5 0%, #9f7aea 50%, #d6c2ff 100%) !important;
  color: white !important;
  border: none;
}

.btn-gradient:hover {
  background: linear-gradient(135deg, #7050c0 0%, #8b6ad0 50%, #c1a8f0 100%) !important;
}

.chip-gradient {
  background: linear-gradient(135deg, #7050c0 0%, #8b6ad0 50%, #c1a8f0 100%) !important;
}

.rutina-texto, .plan-texto {
  line-height: 1.6;
  white-space: pre-line;
}

.rutina-texto strong, .plan-texto strong {
  color: #1976d2;
  font-weight: bold;
}

.rutina-texto em, .plan-texto em {
  color: #7b1fa2;
  font-style: italic;
  font-weight: 500;
}

.full-height {
  height: 100%;
}
</style>