<template>
  <div id="google_translate_element"></div>
</template>

<script setup>
import { onMounted } from 'vue'

onMounted(() => {
  const addTranslateScript = () => {
    const script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = '//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit'
    document.head.appendChild(script)
  }

  window.googleTranslateElementInit = () => {
    new window.google.translate.TranslateElement(
      {
        pageLanguage: 'en',
        includedLanguages: 'en,es,fr,de,zh-CN,ja,ko,hi,th,vi,id,ms,fil,ta,bn,km,my,lo,si,ur,ne,ml,te,mr,gu,pa',
        autoDisplay: false
      },
      'google_translate_element'
    )

    // Force reset to English on load
    setTimeout(() => {
      const select = document.querySelector('.goog-te-combo')
      if (select) {
        select.value = 'en' // Set the dropdown to English
        select.dispatchEvent(new Event('change')) // Trigger change event
      }
    }, 500)
  }

  addTranslateScript()
})
</script>
