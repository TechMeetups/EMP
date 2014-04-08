myCustomConfirmBox = function(message, callback) {
var options;
options = [
{
'label': 'Yes, Definitely',
'class': 'btn-danger',
'callback': function() {
if (typeof callback === 'function') {
return callback();
}
}
}, {
'label': 'Opss! No',
'class': 'btn-success'
}
];
return bootbox.dialog(message, options);
};
 
$.rails.allowAction = function(element) {
var answer, callback, message;
message = element.data("confirm");
if (!message) {
return true;
}
answer = false;
callback = void 0;
if ($.rails.fire(element, "confirm")) {
myCustomConfirmBox(message, function() {
var oldAllowAction;
callback = $.rails.fire(element, "confirm:complete", [answer]);
if (callback) {
oldAllowAction = $.rails.allowAction;
$.rails.allowAction = function() {
return true;
};
element.trigger("click");
return $.rails.allowAction = oldAllowAction;
}
});
}
return false;
};