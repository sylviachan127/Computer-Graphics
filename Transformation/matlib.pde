// CS 3451
// Dummy routines for matrix transformations.
// These are for you to write!

void gtInitialize() { }

void gtPushMatrix() { }

void gtPopMatrix() { }

void gtOrtho(float left, float right, float bottom, float top) { }

void gtPerspective(float fov) { }

void gtBeginShape() { }

void gtEndShape() { }

void gtVertex(float x, float y, float z) { }

/******************************************************************************
Transformations: These functions apply a transformation to the Current Transformation Matrix. Use the methods you wrote in the last project to do so.
******************************************************************************/

void gtTranslate(float tx, float ty, float tz) { }

void gtScale(float sx, float sy, float sz) { }

void gtRotate(char axis, float theta) { }

void gtRotate(float theta, float axisX, float axisY, float axisZ) { }