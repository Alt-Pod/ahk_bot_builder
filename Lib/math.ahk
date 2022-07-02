math_cos(deg) {
	return Cos(math_degToRad(deg))
}

math_sin(deg) {
	return Sin(math_degToRad(deg))
}

math_tan(deg) {
	return Tan(math_degToRad(deg))
}

math_aCos(Number) {
	return math_radToDeg(ACos(Number)) 
}

math_aTan(Number) {
	return math_radToDeg(ATan(Number)) 
}

math_degToRad(deg) {
	return deg*math_pi()/180
}

math_radToDeg(rad) {
	return rad*180/math_pi()
}

math_pi() {
	return 3.141592653589793
}

math_cathesianDistance(coord1, coord2) {
	x_dist := coord1.x-coord2.x
	y_dist := coord1.y-coord2.y
	return Sqrt(x_dist*x_dist + y_dist*y_dist)
}

math_dotTranslation(origin, vector) {
	newOriginX := origin.x+vector.x
	newOriginY := origin.y+vector.y
	result := { x: newOriginX, y: newOriginY }
	return result
}

math_absolute(value) {
	if(value < 0) {
		return -value
	}
	return value
}

math_getCarthesianAngle(center, point) {
	centerX := center.x
	centerY := center.y
	pointX := point.x
	pointY := point.y
	angle := math_absolute(math_aTan((centerY-pointY)/(pointX-centerX)))
	if((centerY-pointY) < 0 && (pointX-centerX) > 0) {
		angle := 360 - angle
		return angle
	}
	if((centerY-pointY) < 0) {
		angle := 180 + angle
		return angle
	}
	if((pointX-centerX) < 0) {
		angle := 180 - angle
		return angle
	}
	return angle
}

math_mod(value, mod) {
	result := mod(value, mod)
	if(result < 0) {
		result := result + mod
	}
	return result
}