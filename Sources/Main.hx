package;

import kha.System;

class Main {
	public static function main() {
		System.init("Diagrams", 1024, 768, function () {
			new Diagrams();
		});
	}
}
