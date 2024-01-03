var dl = document.getElementById('download');
var header = document.querySelector('.header');
var headerText = document.getElementById('header-text');
var dltext = document.getElementById('download-text');
var lastScrollTop = 0;

setTimeout(function() {
    headerText.style.opacity = '1';
    headerText.style.transform = 'scale(1)';
    headerText.style.filter = 'none';
}, 500);

document.body.style.overflow = 'hidden';
setTimeout(function() {
    header.style.height = '100px';
    header.style.borderRadius = '0 0 50px 50px';
    header.style.border = '4px solid rgb(255, 255, 255, 0.2)';
    dl.style.display = 'flex';
    headerText.style.left = '20px';
    setTimeout(function() {
        header.classList.add('bounce');
        document.body.style.overflow = 'auto';
    }, 0);
}, 1500);

setTimeout(function() {
    dl.style.opacity = 1;
    dl.style.transform = 'scale(1)';
    dl.style.filter = 'none';
}, 2500);

window.addEventListener('scroll', function() {
    var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    if (scrollTop > lastScrollTop) {
        // Downscroll
        header.style.height = '50px';
        header.style.borderRadius = '0 0 30px 30px';
        headerText.style.fontSize = '20px';
        header.style.border = '3px solid rgb(255, 255, 255, 0.2)';
        dl.style.top = '7px';
        dl.style.right = '20px';
        dl.style.height = '35px';
        dltext.style.fontSize = '15px';
    } else {
        // Upscroll
        header.style.height = '80px';
        header.style.borderRadius = '0 0 50px 50px';
        headerText.style.fontSize = '25px';
        header.style.border = '4px solid rgb(255, 255, 255, 0.2)';
        dl.style.top = '15px';
        dl.style.right = '25px';
        dl.style.height = '50px';
        dltext.style.fontSize = '20px';
    }
    lastScrollTop = scrollTop;
});