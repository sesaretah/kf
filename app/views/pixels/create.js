$("#settings-detail").replaceWith("<%= escape_javascript(render(:partial => 'pixels/business_pixel')) %>");
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :added_successfully%>'
}).show();
