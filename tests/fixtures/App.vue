<script setup lang="ts">
const title = "Railscasts"
</script>

<template>
  <main :class="{ published: true }" class="episode">{{ title.toUpperCase() }}</main>
</template>
