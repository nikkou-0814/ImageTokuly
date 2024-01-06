var dl = document.getElementById('download');
var header = document.querySelector('.header');
var headerText = document.getElementById('header-text');
var dltext = document.getElementById('download-text');
var image = document.getElementById('image');
var toptext1 = document.getElementById('toppage-text1');
var toptext2 = document.getElementById('toppage-text2');
var dlbtn = document.querySelector('.dlbtn');
var sp = document.getElementById('sp');
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
    headerText.style.fontSize = '24px';
    setTimeout(function() {
        header.classList.add('bounce');
        document.body.style.overflow = 'auto';
    }, 0);
}, 1500);

setTimeout(function() {
    toptext1.style.opacity = 1;
    toptext1.style.transform = 'scale(1)';
    toptext1.style.filter = 'none';
    header.classList.delete('bounce');
}, 2000);

setTimeout(function() {
    toptext2.style.opacity = 1;
    toptext2.style.transform = 'scale(1)';
    toptext2.style.filter = 'none';

}, 2500);

setTimeout(function() {
    image.style.opacity = 1;
    image.style.transform = 'scale(1)';
    image.style.filter = 'none';
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
        dlbtn.style.height = '15px';
        dlbtn.style.width = '15px';
    } else {
        // Upscroll
        header.style.height = '60px';
        header.style.borderRadius = '0 0 40px 40px';
        headerText.style.fontSize = '24px';
        header.style.border = '3px solid rgb(255, 255, 255, 0.2)';
        dl.style.top = '7px';
        dl.style.right = '25px';
        dl.style.height = '40px';
        dl.style.borderRadius = '15px'
        dltext.style.fontSize = '20px';
        dlbtn.style.height = '20px';
        dlbtn.style.width = '20px';
    }
    lastScrollTop = scrollTop;
});

window.addEventListener('scroll', function() {
    if (window.scrollY === 0) {
        dl.style.transform = 'scale(0.5)';
        dl.style.filter = 'blur(30px)';
        dl.style.opacity = '0';
        headerText.style.transition = 'all 0.6s cubic-bezier(0.22, 1, 0.36, 1)';
        headerText.style.left = '50%';
        headerText.style.transform = 'translateX(-50%)';
    } else {
        dl.style.transform = 'scale(1)';
        dl.style.filter = 'none';
        dl.style.opacity = '1';
        headerText.style.left = '20px';
        headerText.style.transform = 'none';
    }

});

window.addEventListener('scroll', function() {
    const elements = document.querySelectorAll('.footer, .indn-text, .images, .linksbtn-active, .linksbtn');
    const windowHeight = window.innerHeight;

    elements.forEach(function(element) {
        const elementTop = element.getBoundingClientRect().bottom;

        if (elementTop < windowHeight) {
            element.style.opacity = 1;
            element.style.transform = 'scale(1)';
            element.style.filter = 'none';
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    var imgsc2 = document.getElementById('imgsc2');
    var imgsc3 = document.querySelector('#imgsc3');
    var imgsc4 = document.querySelector('#imgsc4');
    var hoverText1 = imgsc2.querySelector('.hover-text1');
    var hoverText2 = imgsc3.querySelector('.hover-text2');
    var hoverText3 = imgsc4.querySelector('.hover-text3');

    imgsc2.addEventListener('mouseover', function() {
        hoverText1.style.opacity = '1';
        hoverText1.style.transform = 'scale(1)';
        hoverText1.style.filter = 'none';
    });

    imgsc2.addEventListener('mouseout', function() {
        hoverText1.style.opacity = '0';
        hoverText1.style.transform = 'scale(0.5)';
        hoverText1.style.filter = 'blur(30px)';
    });

    imgsc3.addEventListener('mouseover', function() {
        hoverText2.style.opacity = '1';
        hoverText2.style.transform = 'scale(1)';
        hoverText2.style.filter = 'none';
    });

    imgsc3.addEventListener('mouseout', function() {
        hoverText2.style.opacity = '0';
        hoverText2.style.transform = 'scale(0.5)';
        hoverText2.style.filter = 'blur(30px)';
    });

    imgsc4.addEventListener('mouseover', function() {
        hoverText3.style.opacity = '1';
        hoverText3.style.transform = 'scale(1)';
        hoverText3.style.filter = 'none';
    });

    imgsc4.addEventListener('mouseout', function() {
        hoverText3.style.opacity = '0';
        hoverText3.style.transform = 'scale(0.5)';
        hoverText3.style.filter = 'blur(30px)';
    });
});



document.addEventListener('DOMContentLoaded', function() {
    var linksbtn = document.querySelector('.linksbtn');
    var linksactive = document.querySelector('.linksbtn-active');
    var linksbtnsvg = document.querySelector('.linksbtnsvg');
    var linksbtntext = document.getElementById('linksbtntext');
    var linksss = document.getElementById('linksss');
    var links = [link1, link2, link3, link4];
    var delay = 100;

    var isOpen = false; // 状態を追跡するフラグを追加

    linksbtn.addEventListener('click', function() {
        if (!isOpen) {
            var currentWidth = parseFloat(linksactive.style.width);
            linksactive.style.height = '400px';
            linksactive.style.width = (currentWidth + 32) + 'px';
            linksbtn.style.bottom = '490px';
            linksbtn.style.right = '20px';
            linksbtnsvg.style.transform = 'rotate(180deg)';
            linksbtnsvg.style.transformOrigin = '50% 50%'; 
            linksbtnsvg.style.marginTop = '4px';
            linksbtntext.textContent = 'Close Links';
            linksss.style.display = 'flex';
            for (let i = 0; i < links.length; i++) {
                setTimeout(function() {
                    links[i].style.opacity = '1';
                    links[i].style.transform = 'scale(1)';
                    links[i].style.filter = 'none';
                }, i * delay);
            }

            isOpen = true; // 状態を更新
        } else {
            var currentWidth = parseFloat(linksactive.style.width);
            linksactive.style.height = '55px';
            linksactive.style.width = (currentWidth - 32) + 'px';
            linksbtn.style.bottom = '145px';
            linksbtn.style.right = '40px';
            linksbtnsvg.style.transform = 'rotate(0deg)';
            linksbtnsvg.style.marginTop = '7px';
            linksbtntext.textContent = 'Open Links';
            linksss.style.display = 'none';
            for (let i = 0; i < links.length; i++) {
                setTimeout(function() {
                    links[i].style.opacity = '0';
                    links[i].style.transform = 'scale(0.5)';
                    links[i].style.filter = 'blur(30px)';
                }, i * 0);
            }

            isOpen = false; // 状態を更新
        }
    });

    // footer要素の横幅を取得します。
    var footerWidth = document.querySelector('footer').offsetWidth;

    // スタイルを適用する要素を取得します。ここでは、'.linksbtn-active'クラスを持つ要素を対象にしています。
    var targetElement = document.querySelector('.linksbtn-active');

    // 対象の要素の横幅をfooter要素と同じに設定します。
    targetElement.style.width = (footerWidth - 40) + 'px';
});

window.addEventListener('resize', function() {
    // footer要素の横幅を取得します。
    var footerWidth = document.querySelector('footer').offsetWidth;

    // スタイルを適用する要素を取得します。ここでは、'.linksbtn-active'クラスを持つ要素を対象にしています。
    var targetElement = document.querySelector('.linksbtn-active');

    // 対象の要素の横幅をfooter要素と同じに設定します。
    targetElement.style.width = (footerWidth - 40) + 'px';
});