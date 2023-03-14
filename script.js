// Thank you to vantablack of vantaa.black for letting me use their code
// Please see /humans.txt for more credits

var pick=~~(Math.random()*359),
    tag=document.createElement('style'),
    style='::-moz-selection {color:black;text-shadow:rgba(0,0,0,.1)1px 2px 2px;background-color:hsl($pick,75%,50%)!important}::-webkit-selection{color:black;text-shadow:rgba(0,0,0,.1)1px 2px 2px;background-color:hsl($pick,75%,50%)!important}::selection{color:black;text-shadow:rgba(0,0,0,.1)1px 2px 2px;background-color:hsl($pick,75%,50%)!important}';
  tag.innerHTML=style.replace(/\$pick/g,pick);
  document.body.appendChild(tag);