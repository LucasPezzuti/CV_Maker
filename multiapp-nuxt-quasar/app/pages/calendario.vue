<template>
  <q-page class="q-pa-md">
    <!--<div class="text-h5 q-mb-md">Historial de Comidas</div>-->
    
    <!-- Selector de mes y año -->
    <div class="row items-center justify-between q-mb-md">
      <q-btn 
        icon="chevron_left" 
        round 
        dense 
        @click="cambiarMes(-1)" 
        class="q-mr-sm"
      />
      <div class="text-h6">{{ tituloMes }}</div>
      <q-btn 
        icon="chevron_right" 
        round 
        dense 
        @click="cambiarMes(1)" 
        class="q-ml-sm"
      />
    </div>

    <!-- Días de la semana -->
    <div class="row semana-header">
      <div 
        v-for="dia in diasSemana" 
        :key="dia" 
        class="col text-center text-weight-bold"
      >
        {{ dia }}
      </div>
    </div>

    <!-- Calendario -->
    <div class="calendario">
      <div 
        v-for="(dia, index) in diasCalendario" 
        :key="index" 
        class="dia-calendario"
        :class="{
          'dia-actual': esHoy(dia.fecha),
          'dia-seleccionado': esSeleccionado(dia.fecha),
          'otro-mes': !dia.esMesActual,
          'con-comida': dia.tieneComida
        }"
        @click="seleccionarDia(dia)"
      >
        <div class="numero-dia">{{ dia.numero }}</div>
        <div v-if="dia.tieneComida" class="indicador-comida"></div>
      </div>
    </div>

    <!-- Comidas del día seleccionado -->
    <q-card v-if="comidasDelDia.length > 0" class="q-mt-lg">
      <q-card-section>
        <div class="text-h6">Comidas del {{ fechaSeleccionadaFormateada }}</div>
      </q-card-section>
      <q-card-section>
        <q-list bordered>
          <q-item v-for="comida in comidasDelDia" :key="comida.id">
            <q-item-section>
              <q-item-label>{{ comida.tipo }}: {{ comida.descripcion }}</q-item-label>
              <q-item-label caption>{{ comida.calorias }} calorías</q-item-label>
            </q-item-section>
          </q-item>
        </q-list>
      </q-card-section>
    </q-card>

    <!-- Botón flotante para agregar comida -->
    <q-page-sticky position="bottom-right" :offset="[18, 18]">
      <q-btn 
        fab 
        icon="add" 
        color="primary" 
        @click="irAAgregarComida" 
      />
    </q-page-sticky>
  </q-page>
</template>

<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth' // Protege la ruta
})
import { ref, computed, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { date } from 'quasar'
import { useAuthStore } from '~/stores/auth'

const { formatDate } = date
const router = useRouter()
const auth = useAuthStore()

// Estado del calendario
const fechaActual = ref(new Date())
const fechaSeleccionada = ref(new Date())
const comidas = ref([])

// Días de la semana
const diasSemana = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb']

// Obtener el primer día del mes y el último
const primerDiaMes = computed(() => {
  return new Date(fechaActual.value.getFullYear(), fechaActual.value.getMonth(), 1)
})

const ultimoDiaMes = computed(() => {
  return new Date(fechaActual.value.getFullYear(), fechaActual.value.getMonth() + 1, 0)
})

// Título del mes (ej. "Enero 2023")
const tituloMes = computed(() => {
  const opciones = { month: 'long', year: 'numeric' }
  return fechaActual.value.toLocaleDateString('es-ES', opciones)
})

// Generar los días del calendario
const diasCalendario = computed(() => {
  const dias = []
  
  // Días del mes anterior (para completar la primera semana)
  const primerDiaSemana = primerDiaMes.value.getDay() // 0 (domingo) a 6 (sábado)
  for (let i = 0; i < primerDiaSemana; i++) {
    const fecha = new Date(primerDiaMes.value)
    fecha.setDate(fecha.getDate() - (primerDiaSemana - i))
    dias.push({
      fecha: new Date(fecha),
      numero: fecha.getDate(),
      esMesActual: false,
      tieneComida: tieneComidaEnFecha(formatDate(fecha, 'YYYY-MM-DD'))
    })
  }
  
  // Días del mes actual
  for (let i = 1; i <= ultimoDiaMes.value.getDate(); i++) {
    const fecha = new Date(fechaActual.value.getFullYear(), fechaActual.value.getMonth(), i)
    dias.push({
      fecha: fecha,
      numero: i,
      esMesActual: true,
      tieneComida: tieneComidaEnFecha(formatDate(fecha, 'YYYY-MM-DD'))
    })
  }
  
  // Días del siguiente mes (para completar la última semana)
  const ultimoDiaSemana = ultimoDiaMes.value.getDay()
  for (let i = 1; i < (7 - ultimoDiaSemana); i++) {
    const fecha = new Date(ultimoDiaMes.value)
    fecha.setDate(fecha.getDate() + i)
    dias.push({
      fecha: new Date(fecha),
      numero: fecha.getDate(),
      esMesActual: false,
      tieneComida: tieneComidaEnFecha(formatDate(fecha, 'YYYY-MM-DD'))
    })
  }
  
  return dias
})

// Comidas del día seleccionado
const comidasDelDia = computed(() => {
  const fechaFormateada = formatDate(fechaSeleccionada.value, 'YYYY-MM-DD')
  return comidas.value.filter(comida => comida.fecha === fechaFormateada)
})

// Fecha seleccionada formateada
const fechaSeleccionadaFormateada = computed(() => {
  return formatDate(fechaSeleccionada.value, 'DD/MM/YYYY')
})

// Verificar si una fecha tiene comidas
function tieneComidaEnFecha(fecha) {
  return comidas.value.some(comida => comida.fecha === fecha)
}

// Verificar si es el día actual
function esHoy(fecha) {
  return formatDate(fecha, 'YYYY-MM-DD') === formatDate(new Date(), 'YYYY-MM-DD')
}

// Verificar si es el día seleccionado
function esSeleccionado(fecha) {
  return formatDate(fecha, 'YYYY-MM-DD') === formatDate(fechaSeleccionada.value, 'YYYY-MM-DD')
}

// Seleccionar un día
function seleccionarDia(dia) {
  fechaSeleccionada.value = new Date(dia.fecha)
}

// Cambiar de mes
function cambiarMes(incremento) {
  const nuevaFecha = new Date(fechaActual.value)
  nuevaFecha.setMonth(nuevaFecha.getMonth() + incremento)
  fechaActual.value = nuevaFecha
}

// Ir a la página de agregar comida
function irAAgregarComida() {
  const fechaFormateada = formatDate(fechaSeleccionada.value, 'YYYY-MM-DD')
  router.push(`/agregar?fecha=${fechaFormateada}`)
}

// Cargar comidas del mes actual
async function cargarComidasDelMes() {
  try {
    const primerDia = formatDate(primerDiaMes.value, 'YYYY-MM-DD')
    const ultimoDia = formatDate(ultimoDiaMes.value, 'YYYY-MM-DD')
    
    const response = await $fetch(`http://localhost:8000/api/comidas?desde=${primerDia}&hasta=${ultimoDia}`, {
      headers: {
        Authorization: `Bearer ${auth.token}`
      }
    })
    
    // Actualizar comidas para el rango de fechas
    comidas.value = comidas.value.filter(c => {
      const fechaComida = new Date(c.fecha)
      return fechaComida < new Date(primerDia) || fechaComida > new Date(ultimoDia)
    })
    
    comidas.value.push(...response)
  } catch (error) {
    console.error('Error al cargar comidas:', error)
  }
}

// Cargar comidas del día seleccionado (como en tu ejemplo)
async function cargarComidasDelDia() {
  try {
    const fechaFormateada = formatDate(fechaSeleccionada.value, 'YYYY-MM-DD')
    const response = await $fetch(`http://localhost:8000/api/comidas?fecha=${fechaFormateada}`, {
      headers: {
        Authorization: `Bearer ${auth.token}`
      }
    })
    
    // Actualizar solo las comidas de esta fecha
    comidas.value = comidas.value.filter(c => c.fecha !== fechaFormateada)
    comidas.value.push(...response)
  } catch (error) {
    console.error('Error al cargar comidas:', error)
  }
}

// Watchers
watch(fechaActual, cargarComidasDelMes)
watch(fechaSeleccionada, cargarComidasDelDia)

// Al montar el componente
onMounted(() => {
  cargarComidasDelMes()
  cargarComidasDelDia()
})
</script>

<style scoped>
.semana-header {
  margin-bottom: 8px;
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 8px;
}

.semana-header > div {
  padding: 4px;
}

.calendario {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 4px;
}

.dia-calendario {
  position: relative;
  height: 80px;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.dia-calendario:hover {
  background-color: #f5f5f5;
}

.dia-actual {
  border: 2px solid #1976d2;
}

.dia-seleccionado {
  background-color: #e3f2fd;
}

.otro-mes {
  opacity: 0.4;
}

.con-comida .numero-dia {
  font-weight: bold;
  color: #1976d2;
}

.indicador-comida {
  position: absolute;
  bottom: 4px;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: #4caf50;
}

.numero-dia {
  font-size: 1.1em;
}
</style>