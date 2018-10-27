<template>
  <div class="upload-view">
    <vs-row>
      <vs-col vs-offset="2" vs-w="8" class="input-container">
        <h1 class="title">Upload</h1>
        <vs-upload action="/api/file/upload" @single-upload="true" @on-success="successUpload" />
      </vs-col>
    </vs-row>
  </div>
</template>

<script>
export default {
  name: 'Upload',
  props: ['common'],
  
  methods: {
    successUpload () {
      this.$vs.notify({color:'success',title:'Upload Success',text:'Lorem ipsum dolor sit amet, consectetur'})
    }
  }
}
</script>

