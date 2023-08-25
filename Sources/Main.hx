package;

import kha.System;

class Main {
	public static function main() {
		System.init({title: "Diagrams", width: 1024, height: 768, samplesPerPixel: 8}, function () {
			new Diagrams();
		});
	}
}
