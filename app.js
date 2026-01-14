document.addEventListener('DOMContentLoaded', function() {

    function parseVCard(vcardData) {
        const card = {};
        const lines = vcardData.split(/\r\n|\n/);

        lines.forEach(line => {
            const parts = line.split(':');
            if (parts.length < 2) return;

            const key = parts[0].split(';')[0];
            const value = parts.slice(1).join(':');

            switch (key) {
                case 'FN':
                    card.fn = value;
                    break;
                case 'TITLE':
                    card.title = value;
                    break;
                case 'TEL':
                    card.tel = value;
                    break;
                case 'EMAIL':
                    card.email = value;
                    break;
                case 'URL':
                    card.url = value;
                    break;
            }
        });
        return card;
    }

    fetch('contacto.vcf?v=' + new Date().getTime())
        .then(response => response.text())
        .then(vcardData => {
            const card = parseVCard(vcardData);

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
                    phoneLink.href = 'tel:' + card.tel.replace(/\D/g, '');
                    phoneLink.querySelector('span:last-child').textContent = card.tel;
                }

                const emailLink = document.getElementById('contact-email');
                if (emailLink && card.email) {
                    emailLink.href = 'mailto:' + card.email;
                    emailLink.querySelector('span:last-child').textContent = card.email;
                }

                const websiteLink = document.getElementById('contact-website');
                if (websiteLink && card.url) {
                    websiteLink.href = card.url;
                    websiteLink.querySelector('span:last-child').textContent = card.url.replace(/^https?:\/\//, '');
                }
            }
        })
        .catch(error => console.error('Error fetching vCard:', error));
});