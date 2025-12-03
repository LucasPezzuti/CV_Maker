<template>
  <q-page class="q-pa-md">
    <div class="q-gutter-y-md" style="max-width: 600px; margin: 0 auto;">

      <q-banner class="bg-blue-1 banner-violeta q-mb-md">
        <template v-slot:avatar>
          <q-icon name="info" color="white" />
        </template>
        Completa tu información personal para obtener recomendaciones más precisas.
      </q-banner>

      <!-- Sección 1: Datos Personales -->
      <q-card class="q-mb-md card-hover">
        <q-expansion-item
          v-model="datosExpandido"
          icon="person"
          label="Datos Personales"
          header-class="text-h6 expansion-header clickeable"
        >
          <template v-slot:header>
            <q-item-section avatar>
              <q-icon name="person" color="primary" />
            </q-item-section>
            <q-item-section>
              <div class="text-h6">Datos Personales</div>
              <div class="text-caption text-grey-6" v-if="!datosExpandido && perfilCompleto">
                {{ perfil.edad }} años, {{ perfil.genero }}, {{ perfil.objetivo }}
              </div>
            </q-item-section>
          </template>

          <q-separator />

          <q-card-section>
            <q-form @submit="guardarPerfil" class="q-gutter-md">

              <!-- Nombre (solo lectura, viene del usuario) -->
              <q-input filled v-model="auth.user" label="Nombre completo" readonly :dense="true" />

              <div class="row q-gutter-md">
                <!-- Edad -->
                <q-input filled v-model.number="perfil.edad" label="Edad" type="number" min="15" max="100"
                  style="min-width: 120px;" :dense="true"
                  :rules="[val => val >= 15 && val <= 100 || 'Edad entre 15 y 100 años']" />

                <!-- Género -->
                <q-select filled v-model="perfil.genero" :options="opcionesGenero" label="Género"
                  style="min-width: 150px;" :dense="true" />
              </div>

              <div class="row q-gutter-md">
                <!-- Peso -->
                <q-input filled v-model.number="perfil.peso" label="Peso (kg)" type="number" step="0.1" min="30" max="200"
                  suffix="kg" style="min-width: 140px;" :dense="true"
                  :rules="[val => val >= 30 && val <= 200 || 'Peso entre 30 y 200 kg']" />

                <!-- Altura -->
                <q-input filled v-model.number="perfil.altura" label="Altura (cm)" type="number" min="100" max="250"
                  suffix="cm" style="min-width: 140px;" :dense="true"
                  :rules="[val => val >= 100 && val <= 250 || 'Altura entre 100 y 250 cm']" />
              </div>

              <!-- Objetivo -->
              <q-select filled v-model="perfil.objetivo" :options="opcionesObjetivo" label="Objetivo principal"
                :dense="true" />

              <!-- Nivel de actividad -->
              <q-select filled v-model="perfil.nivelActividad" :options="opcionesActividad"
                label="Nivel de actividad física" :dense="true" map-options emit-value />

              <!-- Botones -->
              <div class="row q-gutter-md justify-end">
                <q-btn label="Guardar" type="submit" class="btn-gradient" :loading="guardando" :disable="guardando" />
              </div>
            </q-form>
          </q-card-section>
        </q-expansion-item>
      </q-card>

      <!-- Sección 2: Progreso -->
      <q-card class="q-mb-md card-hover" v-if="perfil.peso && perfil.altura">
        <q-expansion-item
          v-model="progresoExpandido"
          icon="trending_up"
          label="Tu Progreso"
          header-class="text-h6 expansion-header clickeable"
        >
          <template v-slot:header>
            <q-item-section avatar>
              <q-icon name="trending_up" color="secondary" />
            </q-item-section>
            <q-item-section>
              <div class="text-h6">Tu Progreso</div>
              <div class="text-caption text-grey-6" v-if="!progresoExpandido">
                IMC: {{ calcularIMC() }} | Meta: {{ calcularCalorias() }} cal
              </div>
            </q-item-section>
          </template>

          <q-separator />

          <q-card-section>
            <!-- Estadísticas principales -->
            <div class="row q-gutter-md items-center q-mb-md">
              <!-- IMC -->
              <q-chip class="chip-violeta" text-color="white" icon="monitor_weight">
                IMC: {{ calcularIMC() }} ({{ clasificarIMC() }})
              </q-chip>

              <!-- Peso actual -->
              <q-chip class="chip-secundario" text-color="white" icon="fitness_center">
                Peso: {{ perfil.peso }} kg
              </q-chip>
            </div>

            <!-- Meta calórica estimada -->
            <div class="q-mb-lg">
              <q-banner class="banner-secundario">
                <template v-slot:avatar>
                  <q-icon name="local_fire_department" color="white" />
                </template>
                <strong>Meta calórica diaria estimada:</strong> {{ calcularCalorias() }} calorías
              </q-banner>
            </div>

            <!-- Progreso de peso -->
            <div v-if="progresoData.mostrar" class="q-mb-md">
              <div class="text-subtitle2 q-mb-sm flex items-center">
                <q-icon name="timeline" class="q-mr-sm" color="primary" />
                Progreso de Peso
              </div>
              
              <!-- Barra de progreso -->
              <div class="progress-container q-mb-md">
                <div class="progress-labels row justify-between q-mb-xs">
                  <span class="text-caption text-grey-6">{{ progresoData.pesoInicial }} kg</span>
                  <span class="text-caption font-weight-bold">{{ progresoData.pesoActual }} kg</span>
                  <span class="text-caption text-grey-6">{{ progresoData.pesoObjetivo }} kg</span>
                </div>
                
                <q-linear-progress
                  :value="progresoData.porcentaje"
                  size="20px"
                  :color="progresoData.color"
                  class="rounded-progress"
                >
                  <div class="absolute-full flex flex-center">
                    <q-badge 
                      :color="progresoData.color" 
                      text-color="white" 
                      :label="`${Math.round(progresoData.porcentaje * 100)}%`"
                    />
                  </div>
                </q-linear-progress>
              </div>

              <!-- Estadísticas del progreso -->
              <div class="row q-gutter-sm">
                <q-chip 
                  :color="progresoData.variacion >= 0 ? 'negative' : 'positive'"
                  text-color="white"
                  icon="trending_up"
                  size="sm"
                >
                  {{ progresoData.variacion >= 0 ? '+' : '' }}{{ progresoData.variacion.toFixed(1) }} kg
                </q-chip>
                
                <q-chip 
                  color="grey-6"
                  text-color="white"
                  icon="calendar_month"
                  size="sm"
                >
                  {{ progresoData.diasRegistrando }} días
                </q-chip>

                <q-chip 
                  class="chip-violeta"
                  text-color="white"
                  icon="flag"
                  size="sm"
                >
                  {{ Math.abs(progresoData.pesoActual - progresoData.pesoObjetivo).toFixed(1) }} kg restantes
                </q-chip>
              </div>
            </div>

            <!-- Mensaje motivacional -->
            <div v-if="mensajeMotivacional" class="q-mt-md">
              <q-banner class="bg-purple-1 text-purple-8">
                <template v-slot:avatar>
                  <q-icon name="psychology" color="purple" />
                </template>
                {{ mensajeMotivacional }}
              </q-banner>
            </div>
          </q-card-section>
        </q-expansion-item>
      </q-card>

      <!-- Sección 3: Historial de Pesos -->
      <q-card class="q-mb-md card-hover" v-if="historialPesos.length">
        <q-expansion-item
          v-model="historialExpandido"
          icon="history"
          label="Historial de Pesos"
          header-class="text-h6 expansion-header clickeable"
        >
          <template v-slot:header>
            <q-item-section avatar>
              <q-icon name="history" color="amber" />
            </q-item-section>
            <q-item-section>
              <div class="text-h6">Historial de Pesos</div>
              <div class="text-caption text-grey-6" v-if="!historialExpandido">
                {{ historialPesos.length }} registros
              </div>
            </q-item-section>
          </template>

          <q-separator />

          <q-card-section>
            <!-- Gráfico simple con CSS -->
            <div v-if="historialPesos.length > 1" class="q-mb-md">
              <div class="text-subtitle2 q-mb-sm flex items-center">
                <q-icon name="show_chart" class="q-mr-sm" color="secondary" />
                Tendencia
              </div>
              
              <div class="chart-container">
                <div class="chart-bars">
                  <div
                    v-for="(registro, index) in historialParaGrafico"
                    :key="index"
                    class="chart-bar"
                    :style="{ 
                      height: `${calcularAlturaBar(registro.peso)}%`,
                      backgroundColor: index === historialParaGrafico.length - 1 ? '#805ad5' : '#d6c2ff'
                    }"
                  >
                    <div class="bar-value">{{ registro.peso }}</div>
                  </div>
                </div>
                <div class="chart-labels">
                  <span 
                    v-for="(registro, index) in historialParaGrafico"
                    :key="index"
                    class="chart-label"
                  >
                    {{ formatFechaCorta(registro.created_at) }}
                  </span>
                </div>
              </div>
            </div>

            <q-list bordered separator class="rounded-borders">
              <q-item v-for="(registro, index) in historialPesos" :key="index" class="q-py-sm">
                <q-item-section avatar>
                  <q-avatar 
                    :color="index === 0 ? 'secondary' : 'grey-4'" 
                    :text-color="index === 0 ? 'white' : 'grey-7'"
                    size="sm"
                  >
                    {{ historialPesos.length - index }}
                  </q-avatar>
                </q-item-section>
                
                <q-item-section>
                  <q-item-label>{{ formatFecha(registro.created_at) }}</q-item-label>
                  <q-item-label caption class="row items-center">
                    <span class="text-weight-bold q-mr-sm">{{ registro.peso }} kg</span>
                    <span v-if="registro.variacion"
                      :class="{ 'text-positive': registro.variacion < 0, 'text-negative': registro.variacion > 0 }">
                      ({{ registro.variacion > 0 ? '+' : '' }}{{ registro.variacion }} kg)
                    </span>
                  </q-item-label>
                </q-item-section>

                <q-item-section side>
                  <q-icon 
                    v-if="registro.variacion"
                    :name="registro.variacion < 0 ? 'trending_down' : 'trending_up'"
                    :color="registro.variacion < 0 ? 'positive' : 'negative'"
                  />
                </q-item-section>
              </q-item>
            </q-list>
          </q-card-section>
        </q-expansion-item>
      </q-card>

      <!-- Sección 4: Estadísticas rápidas -->
      <q-card v-if="perfil.peso && perfil.altura" class="card-hover">
        <q-card-section>
          <div class="text-h6 q-mb-md flex items-center">
            <q-icon name="analytics" class="q-mr-sm" color="primary" />
            Resumen Rápido
          </div>
          
          <div class="stats-grid">
            <div class="stat-item">
              <q-icon name="straighten" color="primary" size="md" />
              <div class="stat-value">{{ perfil.altura }} cm</div>
              <div class="stat-label">Altura</div>
            </div>
            
            <div class="stat-item">
              <q-icon name="cake" color="secondary" size="md" />
              <div class="stat-value">{{ perfil.edad }} años</div>
              <div class="stat-label">Edad</div>
            </div>
            
            <div class="stat-item">
              <q-icon name="directions_run" color="amber" size="md" />
              <div class="stat-value">{{ perfil.nivelActividad || 'N/D' }}</div>
              <div class="stat-label">Actividad</div>
            </div>
          </div>
        </q-card-section>
      </q-card>

      <!-- Mensaje si no hay datos -->
      <q-card v-if="!perfil.peso && !perfil.altura && !cargando" class="text-center q-pa-lg card-hover">
        <q-icon name="info" size="xl" color="grey-5" class="q-mb-md" />
        <div class="text-h6 text-grey-6 q-mb-sm">¡Bienvenido!</div>
        <div class="text-grey-6 q-mb-md">Completa tus datos personales para ver tu progreso e historial</div>
        <q-btn 
          @click="datosExpandido = true" 
          class="btn-gradient" 
          label="Completar Datos" 
          icon="edit"
        />
      </q-card>
    </div>

    <!-- Loader -->
    <q-inner-loading :showing="cargando || guardando">
      <q-spinner-gears size="50px" color="primary" />
      <div class="q-mt-md text-center">{{ cargando ? 'Cargando datos...' : 'Guardando...' }}</div>
    </q-inner-loading>
  </q-page>
</template>

<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth' // Protege la ruta
})
import { ref, onMounted, computed } from 'vue'
import { useQuasar } from 'quasar'
import { date } from 'quasar'
import { useAuthStore } from '~/stores/auth'
import axios from 'axios'

const $q = useQuasar()
const auth = useAuthStore()
// Estados de expansión
const datosExpandido = ref(false) 
const progresoExpandido = ref(false)
const historialExpandido = ref(false)

// Datos del perfil
const perfil = ref({
  nombre: '',
  edad: null,
  genero: null,
  peso: null,
  altura: null,
  objetivo: null,
  nivelActividad: null
})

const opcionesGenero = ['Masculino', 'Femenino', 'Otro']
const opcionesObjetivo = [
  'Perder peso',
  'Mantener peso',
  'Ganar masa muscular',
  'Mejorar salud general'
]
const opcionesActividad = [
  'Sedentario',
  'Ligera',
  'Moderada',
  'Activa',
  'Muy activa'
]

// Estados
const historialPesos = ref([])
const cargando = ref(false)
const guardando = ref(false)

// Computed para historial ordenado para el gráfico (del más antiguo al más reciente)
const historialParaGrafico = computed(() => {
  if (historialPesos.value.length === 0) return []
  
  // Tomamos los últimos 10 registros y los ordenamos del más antiguo al más reciente
  return [...historialPesos.value]
    .slice(-10)
    .reverse()
})

// Computed para datos de progreso
const perfilCompleto = computed(() => {
  return perfil.value.edad && perfil.value.genero && perfil.value.objetivo
})

const progresoData = computed(() => {
  if (historialPesos.value.length < 3) {
    return { mostrar: false }
  }

  const registros = [...historialPesos.value].reverse() // Del más antiguo al más reciente
  const pesoInicial = registros[0].peso
  const pesoActual = registros[registros.length - 1].peso
  
  // Calcular peso objetivo basado en el objetivo
  let pesoObjetivo = pesoActual
  if (perfil.value.objetivo === 'Perder peso') {
    pesoObjetivo = pesoInicial * 0.9 // 10% menos
  } else if (perfil.value.objetivo === 'Ganar masa muscular') {
    pesoObjetivo = pesoInicial * 1.1 // 10% más
  }

  const variacion = pesoActual - pesoInicial
  const progresoHaciaObjetivo = Math.abs(pesoInicial - pesoActual) / Math.abs(pesoInicial - pesoObjetivo)
  const porcentaje = Math.min(Math.max(progresoHaciaObjetivo, 0), 1)
  
  // Calcular días registrando
  const fechaInicial = new Date(registros[0].created_at)
  const fechaActual = new Date(registros[registros.length - 1].created_at)
  const diasRegistrando = Math.ceil((fechaActual - fechaInicial) / (1000 * 60 * 60 * 24))

  // Determinar color del progreso
  let color = 'primary'
  if (perfil.value.objetivo === 'Perder peso' && variacion < 0) color = 'positive'
  else if (perfil.value.objetivo === 'Ganar masa muscular' && variacion > 0) color = 'positive'
  else if (Math.abs(variacion) < 1) color = 'amber'

  return {
    mostrar: true,
    //pesoInicial: pesoInicial.toFixed(1),
    //pesoActual: pesoActual.toFixed(1),
    //pesoObjetivo: pesoObjetivo.toFixed(1),
    variacion,
    porcentaje,
    color,
    diasRegistrando
  }
})

const mensajeMotivacional = computed(() => {
  if (!progresoData.value.mostrar) return ''
  
  const { variacion, diasRegistrando } = progresoData.value
  const objetivo = perfil.value.objetivo

  if (diasRegistrando < 7) {
    return '¡Excelente inicio! La constancia es la clave del éxito.'
  }

  if (objetivo === 'Perder peso' && variacion < -2) {
    return '¡Fantástico progreso! Estás en el camino correcto hacia tu meta.'
  } else if (objetivo === 'Ganar masa muscular' && variacion > 1) {
    return '¡Muy bien! Tu ganancia de peso muestra que estás construyendo masa muscular.'
  } else if (Math.abs(variacion) < 1 && objetivo === 'Mantener peso') {
    return '¡Perfecto! Mantienes un peso estable, sigue así.'
  } else if (diasRegistrando > 30) {
    return '¡Un mes registrando! La disciplina que muestras es admirable.'
  }

  return 'Cada paso cuenta. ¡Sigue trabajando hacia tu objetivo!'
})

// Cargar datos del perfil
onMounted(() => {
  cargarPerfil()
})

async function cargarPerfil() {
  cargando.value = true
  try {
    const response = await axios.get('http://localhost:8000/api/profile', {
      headers: {
        Authorization: `Bearer ${auth.token}`
      }
    })

    const data = response.data

    // Llenar datos del perfil
    if (data.profile) {
      perfil.value = {
        nombre: auth.user?.name || '',
        edad: data.profile.edad,
        genero: data.profile.genero,
        peso: data.current_weight?.peso || null,
        altura: data.profile.altura,
        objetivo: data.profile.objetivo,
        nivelActividad: data.profile.nivel_actividad
      }
    } else {
      perfil.value.nombre = auth.user?.name || ''
    }

    // Cargar historial de pesos
    if (data.weight_records) {
      historialPesos.value = data.weight_records
    }

  } catch (error) {
    console.error('Error al cargar perfil:', error)
    $q.notify({
      type: 'negative',
      message: 'Error al cargar los datos del perfil'
    })
  } finally {
    cargando.value = false
  }
}

async function guardarPerfil() {
  guardando.value = true

  try {
    const datosParaEnviar = {
      edad: perfil.value.edad,
      genero: perfil.value.genero,
      altura: perfil.value.altura,
      objetivo: perfil.value.objetivo,
      nivel_actividad: perfil.value.nivelActividad,
      peso: perfil.value.peso
    }

    const response = await axios.post('http://localhost:8000/api/profile', datosParaEnviar, {
      headers: {
        Authorization: `Bearer ${auth.token}`
      }
    })

    $q.notify({
      type: 'positive',
      message: response.data.message || 'Perfil guardado correctamente'
    })

    // Recargar datos para actualizar historial
    await cargarPerfil()

    // Expandir automáticamente la sección de progreso después de guardar
    if (perfil.value.peso && perfil.value.altura) {
      progresoExpandido.value = true
    }

  } catch (error) {
    console.error('Error al guardar perfil:', error)
    $q.notify({
      type: 'negative',
      message: error.response?.data?.message || 'Error al guardar el perfil'
    })
  } finally {
    guardando.value = false
  }
}

function calcularIMC() {
  if (!perfil.value.peso || !perfil.value.altura) return 0
  const alturaMetros = perfil.value.altura / 100
  return (perfil.value.peso / (alturaMetros * alturaMetros)).toFixed(1)
}

function clasificarIMC() {
  const imc = calcularIMC()
  if (imc < 18.5) return 'Bajo peso'
  if (imc < 25) return 'Normal'
  if (imc < 30) return 'Sobrepeso'
  return 'Obesidad'
}

function calcularCalorias() {
  if (!perfil.value.peso || !perfil.value.altura || !perfil.value.edad || !perfil.value.genero || !perfil.value.nivelActividad) {
    return 'Completa tus datos'
  }

  let tmb = 0
  if (perfil.value.genero === 'Masculino') {
    tmb = 10 * perfil.value.peso + 6.25 * perfil.value.altura - 5 * perfil.value.edad + 5
  } else {
    tmb = 10 * perfil.value.peso + 6.25 * perfil.value.altura - 5 * perfil.value.edad - 161
  }

  const factores = {
    'Sedentario': 1.2,
    'Ligera': 1.375,
    'Moderada': 1.55,
    'Activa': 1.725,
    'Muy activa': 1.9
  }

  const factor = factores[perfil.value.nivelActividad] || 1.2
  let calorias = tmb * factor

  if (perfil.value.objetivo === 'Perder peso') {
    calorias -= 500
  } else if (perfil.value.objetivo === 'Ganar masa muscular') {
    calorias += 300
  }

  return Math.round(calorias)
}

function formatFecha(fechaISO) {
  return date.formatDate(fechaISO, 'DD/MM/YYYY HH:mm')
}

function formatFechaCorta(fechaISO) {
  return date.formatDate(fechaISO, 'DD/MM')
}

function calcularAlturaBar(peso) {
  if (historialParaGrafico.value.length === 0) return 0
  
  const pesos = historialParaGrafico.value.map(r => r.peso)
  const minPeso = Math.min(...pesos)
  const maxPeso = Math.max(...pesos)
  
  if (minPeso === maxPeso) return 50
  
  return 20 + (peso - minPeso) / (maxPeso - minPeso) * 60
}
</script>

<style scoped>
.banner-violeta {
  background: linear-gradient(135deg, #805ad5 0%, #9f7aea 50%, #d6c2ff 100%) !important;
  color: white;
  border-radius: 8px;
}

.banner-secundario {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%) !important;
  color: white;
  border-radius: 8px;
}

.btn-gradient {
  background: linear-gradient(135deg, #805ad5 0%, #9f7aea 50%, #d6c2ff 100%) !important;
  color: white !important;
  border: none;
}

.btn-gradient:hover {
  background: linear-gradient(135deg, #7050c0 0%, #8b6ad0 50%, #c1a8f0 100%) !important;
}

.chip-violeta {
  background: linear-gradient(135deg, #805ad5 0%, #9f7aea 100%) !important;
}

.chip-secundario {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%) !important;
}

.card-hover {
  transition: all 0.3s ease;
  border: 1px solid transparent;
}

.card-hover:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(128, 90, 213, 0.15);
  border-color: rgba(128, 90, 213, 0.2);
}

/* Headers clickeables completamente */
:deep(.clickeable) {
  cursor: pointer !important;
  padding: 16px;
  width: 100%;
}

:deep(.clickeable .q-item__section--side) {
  color: #805ad5;
}

:deep(.clickeable .q-focus-helper) {
  background: rgba(128, 90, 213, 0.1);
}

:deep(.clickeable:hover) {
  background-color: rgba(128, 90, 213, 0.05);
}

:deep(.q-expansion-item__toggle-icon) {
  cursor: pointer;
}

/* Barra de progreso personalizada */
.progress-container {
  background: #f5f5f5;
  border-radius: 12px;
  padding: 4px;
}

.rounded-progress {
  border-radius: 8px;
  overflow: hidden;
}

.progress-labels {
  font-size: 11px;
  padding: 0 4px;
}

/* Gráfico simple */
.chart-container {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 16px;
  margin: 8px 0;
}

.chart-bars {
  display: flex;
  align-items: end;
  justify-content: space-around;
  height: 100px;
  margin-bottom: 8px;
  gap: 4px;
}

.chart-bar {
  min-width: 20px;
  border-radius: 4px 4px 0 0;
  position: relative;
  transition: all 0.3s ease;
  display: flex;
  align-items: end;
  justify-content: center;
  padding-bottom: 4px;
}

.chart-bar:hover {
  transform: scaleY(1.05);
}

.bar-value {
  font-size: 10px;
  font-weight: bold;
  color: white;
  text-shadow: 0 1px 2px rgba(0,0,0,0.3);
}

.chart-labels {
  display: flex;
  justify-content: space-around;
}

.chart-label {
  font-size: 10px;
  color: #666;
  text-align: center;
}

/* Grid de estadísticas */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
  gap: 16px;
  margin-top: 16px;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 16px;
  background: linear-gradient(135deg, rgba(128, 90, 213, 0.1) 0%, rgba(240, 147, 251, 0.1) 100%);
  border-radius: 12px;
  border: 1px solid rgba(128, 90, 213, 0.2);
  transition: all 0.3s ease;
}

.stat-item:hover {
  transform: translateY(-2px);
  background: linear-gradient(135deg, rgba(128, 90, 213, 0.15) 0%, rgba(240, 147, 251, 0.15) 100%);
  border-color: rgba(128, 90, 213, 0.3);
}

.stat-value {
  font-size: 18px;
  font-weight: bold;
  margin: 8px 0 4px 0;
  background: linear-gradient(135deg, #805ad5 0%, #f093fb 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.stat-label {
  font-size: 12px;
  color: #666;
  font-weight: 500;
}

/* Animaciones suaves */
.q-expansion-item {
  transition: all 0.3s ease;
}

/* Mejoras en el historial */
:deep(.q-item) {
  border-radius: 8px;
  margin-bottom: 2px;
}

:deep(.q-item:hover) {
  background-color: rgba(128, 90, 213, 0.05);
}

/* Responsive adjustments */
@media (max-width: 600px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .chart-bars {
    height: 80px;
  }
  
  .stat-item {
    padding: 12px;
  }
  
  .stat-value {
    font-size: 16px;
  }
}
</style>