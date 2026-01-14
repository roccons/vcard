document.addEventListener('DOMContentLoaded', function() {
    fetch('contacto.vcf')
        .then(response => response.text())
        .then(vcardData => {
            const card = vCard.parse(vcardData);

            if (card) {
                const nameElement = document.getElementById('contact-name');
                if (nameElement && card.fn) {
                    nameElement.textContent = card.fn;
                }

                const titleElement = document.getElementById('contact-title');
                if (titleElement && card.title) {
                    titleElement.textContent = card.title;
                }

                const phoneLink = document.getElementById('contact-phone');
                if (phoneLink && card.tel) {
                    const telValue = Array.isArray(card.tel) ? card.tel[0].value : card.tel.value;
                    phoneLink.href = 'tel:' + telValue.replace(/\D/g, '');
                    phoneLink.querySelector('span').textContent = telValue;
                }

                const emailLink = document.getElementById('contact-email');
                if (emailLink && card.email) {
                    const emailValue = Array.isArray(card.email) ? card.email[0].value : card.email.value;
                    emailLink.href = 'mailto:' + emailValue;
                    emailLink.querySelector('span').textContent = emailValue;
                }

                const websiteLink = document.getElementById('contact-website');
                if (websiteLink && card.url) {
                    const urlValue = Array.isArray(card.url) ? card.url[0].value : card.url.value;
                    websiteLink.href = urlValue;
                    websiteLink.querySelector('span').textContent = urlValue.replace(/^https?:\/\//, '');
                }
            }
        })
        .catch(error => console.error('Error fetching or parsing vCard:', error));
});