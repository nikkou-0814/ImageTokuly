var dl = document.getElementById('download');
var header = document.querySelector('.header');
var headerText = document.getElementById('header-text');
var dltext = document.getElementById('download-text');
var image = document.getElementById('image');
var toptext1 = document.getElementById('toppage-text1');
var toptext2 = document.getElementById('toppage-text2');
var lastScrollTop = 0;

setTimeout(function() {
    headerText.style.opacity = '1';
    headerText.style.transform = 'scale(1)';
    headerText.style.filter = 'none';
}, 500);

document.body.style.overflow = 'hidden';
setTimeout(function() {
    header.style.height = '70px';
    header.style.borderRadius = '0 0 50px 50px';
    header.style.border = '3px solid rgb(255, 255, 255, 0.2)';
    dl.style.display = 'flex';
    headerText.style.left = '20px';
    headerText.style.fontSize = '24px';
    setTimeout(function() {
        header.classList.add('bounce');
        document.body.style.overflow = 'auto';
    }, 0);
}, 1500);

setTimeout(function() {
    dl.style.opacity = 1;
    dl.style.transform = 'scale(1)';
    dl.style.filter = 'none';
}, 2000);

setTimeout(function() {
    image.style.opacity = 1;
    image.style.transform = 'scale(1)';
    image.style.filter = 'none';
}, 2000);

setTimeout(function() {
    toptext1.style.opacity = 1;
    toptext1.style.transform = 'scale(1)';
    toptext1.style.filter = 'none';
}, 2500);

setTimeout(function() {
    toptext2.style.opacity = 1;
    toptext2.style.transform = 'scale(1)';
    toptext2.style.filter = 'none';
}, 3000);

window.addEventListener('scroll', function() {
    var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    if (scrollTop > lastScrollTop) {
        // Downscroll
        header.style.height = '45px';
        header.style.borderRadius = '0 0 20px 20px';
        headerText.style.fontSize = '20px';
        header.style.border = '2px solid rgb(255, 255, 255, 0.2)';
        dl.style.top = '8px';
        dl.style.right = '10px';
        dl.style.height = '30px';
        dl.style.borderRadius = '30px'
        dltext.style.fontSize = '15px';
    } else {
        // Upscroll
        header.style.height = '60px';
        header.style.borderRadius = '0 0 40px 40px';
        headerText.style.fontSize = '24px';
        header.style.border = '3px solid rgb(255, 255, 255, 0.2)';
        dl.style.top = '7px';
        dl.style.right = '25px';
        dl.style.height = '45px';
        dl.style.borderRadius = '15px'
        dltext.style.fontSize = '20px';
    }
    lastScrollTop = scrollTop;
});

window.addEventListener('scroll', function() {
    const elements = document.querySelectorAll('.fade-in');
    const windowHeight = window.innerHeight;

    elements.forEach(function(element) {
        const elementTop = element.getBoundingClientRect().top;

        if (elementTop < windowHeight) {
            element.classList.add('show');
        }
    });
});