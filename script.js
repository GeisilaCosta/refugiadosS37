document.addEventListener('DOMContentLoaded', function() {
    const navbar = document.querySelector('.nav');

    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            document.body.classList.add('scrolled');
        } else {
            document.body.classList.remove('scrolled');
        }
    });
});