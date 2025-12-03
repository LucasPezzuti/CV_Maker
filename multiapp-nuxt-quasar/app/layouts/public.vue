<template>
  <q-layout view="hHh lpR fFf">
    <!-- No incluyas q-header aquí para que no aparezca el navbar -->
    <q-page-container>
      <slot />
    </q-page-container>
  </q-layout>
</template>

<script setup>
// Este layout mínimo solo provee el QLayout necesario para QPage
</script>