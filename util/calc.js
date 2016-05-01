function getChangeLeft(ui, scale) {
    return (ui.position.left - ui.originalPosition.left) / scale; // find change in left
}
function getNewLeft(ui, scale) {
    return ui.originalPosition.left + getChangeLeft(ui, scale); // adjust new left by our zoomScale
}
function getChangeTop(ui, scale) {
    return (ui.position.top - ui.originalPosition.top)  / scale; // find change in top
}
function getNewTop(ui, scale) {
    return ui.originalPosition.top + getChangeTop(ui, scale); // adjust new top by our zoomScale
}
function getChangeWidth(ui, scale) {
    return (ui.size.width - ui.originalSize.width) / scale; // find change in width
}
function getNewWidth(ui, scale) {
    return ui.originalSize.width + getChangeWidth(ui, scale); // adjust new width by our zoomScale
}
function getChangeHeight(ui, scale) {
    return (ui.size.height - ui.originalSize.height) / scale; // find change in height
}
function getNewHeight(ui, scale) {
    return ui.originalSize.height + getChangeHeight(ui, scale); // adjust new height by our zoomScale
}
function getPadding() {
    return 10;
}