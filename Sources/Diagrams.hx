package;

import kha.Assets;
import kha.Color;
import kha.Font;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.math.FastMatrix3;
import kha.math.Vector2;
import kha.System;
import kha.Video;

using StringTools;

class FormPainter {
	var painter: Graphics;
	public var resx: Float;
	public var resy: Float;
	
	public function new(painter: Graphics, resx: Float, resy: Float) {
		this.painter = painter;
		this.resx = resx;
		this.resy = resy;
	}
	
	public function drawImage(img: Image, x: Float, y: Float): Void {
		painter.drawImage(img, x * resx, y * resx);
	}
	
	public function drawImage2(image : Image, sx : Float, sy : Float, sw : Float, sh : Float, dx : Float, dy : Float, dw : Float, dh : Float) : Void {
		painter.drawScaledSubImage(image, sx * image.width, sy * image.height, sw * image.width, sh * image.height, dx * resx, dy * resy, dw * resx, dh * resy);
	}
	
	public function setColor(r : Int, g : Int, b : Int) : Void {
		painter.color = Color.fromBytes(r, g, b);
	}
	
	public function drawRect(x : Float, y : Float, width : Float, height : Float) : Void {
		painter.drawRect(x * resx, y * resy, width * resx, height * resy);
	}
	
	public function fillRect(x : Float, y : Float, width : Float, height : Float) : Void {
		painter.fillRect(x * resx, y * resy, width * resx, height * resy);
	}
	
	public function setFont(font : Font) : Void {
		painter.font = font;
	}
	
	public function drawChars(text : String, offset : Int, length : Int, x : Float, y : Float) : Void {
		drawString(text.substr(offset, length), x, y);
	}
	
	public function drawString(text : String, x : Float, y : Float) : Void {
		painter.drawString(text, x * resx, y * resy);
	}
	
	public function drawLine(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Void {
		painter.drawLine(x1 * resx, y1 * resy, x2 * resx, y2 * resy);
	}
	
	public function drawVideo(video : Video, x : Float, y : Float, width : Float, height : Float) : Void {
		painter.drawVideo(video, x * resx, y * resy, width * resx, height * resy);
	}
	
	public function fillTriangle(x1 : Float, y1 : Float, x2 : Float, y2 : Float, x3 : Float, y3 : Float) : Void {
		painter.fillTriangle(x1 * resx, y1 * resy, x2 * resx, y2 * resy, x3 * resx, y3 * resy);
	}
	
	public function translate(x : Float, y : Float) : Void {
		painter.translate(x, y);
	}
	
	public function clear() : Void {
		painter.fillRect(0, 0, resx, resy);
	}
}

class SvgPainter extends FormPainter {
	public var svg: String;
	var tx: Float;
	var ty: Float;
	
	public function new(resx: Float, resy: Float) {
		super(null, resx, resy);
		svg = "";
	}
	
	override public function drawImage(img: Image, x: Float, y: Float): Void {
		//painter.drawImage(img, x * resx, y * resx);
	}
	
	override public function drawImage2(image : Image, sx : Float, sy : Float, sw : Float, sh : Float, dx : Float, dy : Float, dw : Float, dh : Float) : Void {
		//painter.drawImage2(image, sx * image.getWidth(), sy * image.getWidth(), sw * image.getWidth(), sh * image.getHeight(), dx * resx, dy * resy, dw * resx, dh * resy);
	}
	
	override public function setColor(r : Int, g : Int, b : Int) : Void {
		//painter.setColor(r, g, b);
	}
	
	override public function drawRect(x : Float, y : Float, width : Float, height : Float) : Void {
		//painter.drawRect(x * resx, y * resy, width * resx, height * resy);
	}
	
	override public function fillRect(x : Float, y : Float, width : Float, height : Float) : Void {
		//painter.fillRect(x * resx, y * resy, width * resx, height * resy);
		svg += '<rect x="' + (tx + x * resx) + '" y="' + (ty + y * resy) + '" width="' + (width * resx) + '" height="' + (height * resy) + '" fill="grey" stroke="black"/>\n';
	}
	
	override public function setFont(font : Font) : Void {
		//painter.setFont(font);
	}
	
	override public function drawChars(text : String, offset : Int, length : Int, x : Float, y : Float) : Void {
		//drawString(text.substr(offset, length), x, y);
	}
	
	override public function drawString(text : String, x : Float, y : Float) : Void {
		//painter.drawString(text, x * resx, y * resy);
		svg += '<text x="' + (tx + x * resx) + '" y="' + (ty + y * resy + 15) + '">' + text.replace("<", "&lt;").replace(">", "&gt;") + "</text>\n";
	}
	
	override public function drawLine(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Void {
		//painter.drawLine(x1 * resx, y1 * resy, x2 * resx, y2 * resy);
	}
	
	override public function drawVideo(video : Video, x : Float, y : Float, width : Float, height : Float) : Void {
		//painter.drawVideo(video, x * resx, y * resy, width * resx, height * resy);
	}
	
	override public function fillTriangle(x1 : Float, y1 : Float, x2 : Float, y2 : Float, x3 : Float, y3 : Float) : Void {
		//painter.fillTriangle(x1 * resx, y1 * resy, x2 * resx, y2 * resy, x3 * resx, y3 * resy);
		svg += '<path d = "M ' + (tx + x1 * resx) + " " + (ty + y1 * resy) + " L " + (tx + x2 * resx) + " " + (ty + y2 * resy) + " L " + (tx + x3 * resx) + " " + (ty + y3 * resy) + " L " + (tx + x1 * resx) + " " + (ty + y1 * resy) + '" stroke = "none" stroke-width = "3" fill = "red"/>\n';
	}
	
	override public function translate(x : Float, y : Float) : Void {
		//painter.translate(x, y);
		tx = x;
		ty = y;
	}
	
	override public function clear() : Void {
		//painter.fillRect(0, 0, Game.the.width, Game.the.height);
		svg = '<?xml version="1.0" standalone="no" ?>\n';
		svg += '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">\n';
		svg += '<svg width="' + resx + '" height="' + resy + '" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">';
	}
}

class Form {
	public var x: Float;
	public var y: Float;
	public var width: Float;
	public var height: Float;
	public var children: Array<Form>;
	
	public function new() {
		children = new Array<Form>();
	}
	
	public function render(painter: FormPainter): Void {
		
	}
}

class Rect extends Form {
	var title: String;
	static var font: Font;
	static var fontSize: Int;
	
	public static function init(): Void {
		font = Assets.fonts.LiberationSans_Regular;
		fontSize = 15;
	}
	
	public function new(x: Float, y: Float, width: Float, height: Float, title: String) {
		super();
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.title = title;
	}
	
	public function add(form: Form): Void {
		children.push(form);
	}
	
	override public function render(painter: FormPainter): Void {
		painter.setColor(128, 128, 128);
		painter.fillRect(0, 0, width, height);
		painter.setColor(0, 0, 0);
		painter.drawRect(0, 0, width, height);
		
		painter.setColor(0, 0, 0);
		painter.setFont(font);
		var titleWidth = font.width(fontSize, title) / painter.resx;
		var titleHeight = font.height(fontSize) / painter.resy;
		painter.drawString(title, width / 2 - titleWidth / 2, height / 2 - titleHeight / 2);
	}
}

class Text extends Form {
	var title: String;
	static var font: Font;
	static var fontSize: Int;
	
	public static function init(): Void {
		font = Assets.fonts.LiberationSans_Regular;
		fontSize = 15;
	}
	
	public function new(x: Float, y: Float, title: String) {
		super();
		this.x = x;
		this.y = y;
		this.title = title;
	}
	
	public function add(form: Form): Void {
		children.push(form);
	}
	
	override public function render(painter: FormPainter): Void {
		painter.setColor(0, 0, 0);
		painter.setFont(font);
		var titleWidth = font.width(fontSize, title) / painter.resx;
		var titleHeight = font.height(fontSize) / painter.resy;
		painter.drawString(title, -titleWidth / 2, -titleHeight / 2);
	}
}

class Arrow extends Form {
	var start: Vector2;
	var end: Vector2;
	
	public function new(xstart: Float, ystart: Float, xend: Float, yend: Float) {
		super();
		x = xstart;
		y = ystart;
		start = new Vector2(0, 0);
		end = new Vector2(xend - xstart, yend - ystart);
	}
	
	override public function render(painter: FormPainter): Void {
		var dir = end.sub(start);
		dir.length = 1.0;
		var smalldir = new Vector2(dir.x, dir.y);
		smalldir.length = 0.005;
		var _0 = start.add(new Vector2(smalldir.y, -smalldir.x));
		var _1 = start.add(new Vector2(-smalldir.y, smalldir.x));
		var _2 = end.sub(dir.mult(0.01)).add(new Vector2(smalldir.y, -smalldir.x));
		var _3 = end.sub(dir.mult(0.01)).add(new Vector2(-smalldir.y, smalldir.x));
		
		var _4 = end.sub(dir.mult(0.01)).add(new Vector2(smalldir.mult(2).y, -smalldir.mult(2).x));
		var _5 = end.sub(dir.mult(0.01)).add(new Vector2(-smalldir.mult(2).y, smalldir.mult(2).x));
		
		painter.setColor(255, 0, 0);
		painter.fillTriangle(_0.x, _0.y, _1.x, _1.y, _2.x, _2.y);
		painter.fillTriangle(_2.x, _2.y, _1.x, _1.y, _3.x, _3.y);
		painter.fillTriangle(_4.x, _4.y, _5.x, _5.y, end.x, end.y);
	}
}

class Diagrams {
	var forms: Array<Form>;
	var width = 1024;
	var height = 768;
	
	public function new() {
		Assets.loadEverything(function () {
			System.notifyOnRender(render);
			loaded();
		});
	}
	
	function loaded() {
		forms = [];
		Rect.init();
		Text.init();
		
		var game = new Rect(0.45, 0.025, 0.1, 0.1, "Game/App");
		var gameBottom = new Vector2(0.5, 0.125);
		var khaLibsTop = new Vector2(0.5, 0.15);
		var khaLibsBottom = new Vector2(0.5, khaLibsTop.y + 0.2);
		var khaLibs = new Rect(0.5 - 0.35 / 2.0, khaLibsTop.y, 0.35, 0.2, "Kha-Libraries");
		khaLibs.add(new Rect(0.05 - 0.025, 0.6, 0.2, 0.3, "Graphics"));
		khaLibs.add(new Rect(0.3  - 0.025,  0.6, 0.2, 0.3, "Physics"));
		khaLibs.add(new Rect(0.55 - 0.025, 0.6, 0.2, 0.3, "Sound"));
		khaLibs.add(new Rect(0.8  - 0.025,  0.6, 0.2, 0.3, "GUI"));
		
		var haxeCompilerTop = new Vector2(0.4, 0.4);
		var haxeCompilerBottom = new Vector2(0.4, 0.4 + 0.1);
		var kgCompilerTop = new Vector2(0.6, 0.4);
		var kgCompilerBottom = new Vector2(0.6, 0.4 + 0.1);
		var haxeCompiler = new Rect(haxeCompilerTop.x - 0.05, haxeCompilerTop.y, 0.1, 0.1, "Haxe");
		var kgCompiler = new Rect(kgCompilerTop.x - 0.05, kgCompilerTop.y, 0.1, 0.1, "krafix");
		
		var languagesTop = 0.6;
		var languagesBottom = 0.7;
		var cpp = new Rect(0.025, languagesTop, 0.1, 0.1, "C++");
		var javaScript = new Rect(0.15 - 0.025, languagesTop, 0.1, 0.1, "JavaScript");
		var actionScript = new Rect(0.25 - 0.025, languagesTop, 0.1, 0.1, "ActionScript");
		var java = new Rect(0.35 - 0.025, languagesTop, 0.1, 0.1, "Java");
		var cs = new Rect(0.45 - 0.025, languagesTop, 0.1, 0.1, "C#");
		
		var glsl = new Rect(0.6 - 0.025, languagesTop, 0.1, 0.1, "GLSL");
		var glsles = new Rect(0.7 - 0.025, languagesTop, 0.1, 0.1, "Metal");
		var hlsl = new Rect(0.8 - 0.025, languagesTop, 0.1, 0.1, "HLSL");
		var agal = new Rect(0.9 - 0.025, languagesTop, 0.1, 0.1, "AGAL");
		
		var khaBackends = new Rect(0.025, 0.75, 0.95, 0.1, "Kha-Backends");
		
		var kt = new Rect(0.01, 0.1, 0.3, 0.8, "Kore");
		kt.add(new Rect(0.05, 0.05, 0.35, 0.4, "Direct3D 9"));
		kt.add(new Rect(0.05, 0.55, 0.35, 0.4, "Direct3D 11"));
		kt.add(new Rect(0.95 - 0.35, 0.05, 0.35, 0.4, "OpenGL"));
		kt.add(new Rect(0.95 - 0.35, 0.55, 0.35, 0.4, "LibCGM"));
		khaBackends.add(kt);
		
		khaBackends.add(new Rect(0.33, 0.1, 0.1, 0.4, "WebGL"));
		khaBackends.add(new Rect(0.6  - 0.03, 0.5, 0.1, 0.4, "<Canvas>"));
		khaBackends.add(new Rect(0.75 - 0.03, 0.1, 0.1, 0.4, "Stage3D"));
		khaBackends.add(new Rect(0.9  - 0.03, 0.5, 0.1, 0.4, "XNA"));
		
		forms.push(new Arrow(gameBottom.x, gameBottom.y, khaLibsTop.x, khaLibsTop.y));
		forms.push(new Arrow(khaLibsBottom.x, khaLibsBottom.y, haxeCompilerTop.x, haxeCompilerTop.y));
		forms.push(new Arrow(khaLibsBottom.x, khaLibsBottom.y, kgCompilerTop.x, kgCompilerTop.y));
		for (i in 0...5) {
			forms.push(new Arrow(haxeCompilerBottom.x, haxeCompilerBottom.y, 0.025 + 0.05 + i * 0.1, languagesTop));
			forms.push(new Arrow(0.025 + 0.05 + i * 0.1, languagesBottom, 0.025 + 0.05 + i * 0.1, 0.75));
		}
		for (i in 0...4) {
			forms.push(new Arrow(kgCompilerBottom.x, kgCompilerBottom.y, 0.6 - 0.025 + 0.05 + i * 0.1, languagesTop));
			forms.push(new Arrow(0.6 - 0.025 + 0.05 + i * 0.1, languagesBottom, 0.6 - 0.025 + 0.05 + i * 0.1, 0.75));
		}
		for (i in 0...15) {
			forms.push(new Arrow(0.05 + i * 0.9 / 14, 0.85, 0.05 + i * 0.9 / 14, 0.9));
		}
		forms.push(game);
		forms.push(khaLibs);
		forms.push(haxeCompiler);
		forms.push(kgCompiler);
		forms.push(cpp);
		forms.push(javaScript);
		forms.push(actionScript);
		forms.push(java);
		forms.push(cs);
		forms.push(glsl);
		forms.push(glsles);
		forms.push(hlsl);
		forms.push(agal);
		forms.push(khaBackends);
		
		var texts = ["Xbox One", "PlayStation 4", "Switch", "Windows", "macOS", "iOS", "Android", "Windows Universal", "C#/WPF", "XNA", "Java/AWT", "Linux", "Flash", "HTML5", "Tizen"];
		for (i in 0...texts.length) {
			forms.push(new Text(0.05 + i * 0.9 / (texts.length - 1), (i % 2 == 0) ? 0.94 : 0.98, texts[i]));
		}
		
		update();
	}
	
	function update() {
		var painter = new SvgPainter(width, height);
		painter.translate(0, 0);
		painter.clear();
		for (form in forms) {
			renderForm(painter, form, 0, 0, width, height);
		}
		painter.svg += "</svg>";
		var svg = painter.svg;
	}
	
	function render(frame: Framebuffer) {
		var g = frame.g2;
		g.begin();
		g.translate(0, 0);
		g.color = Color.White;
		g.clear(Color.White);
		var formPainter = new FormPainter(g, width, height);
		for (form in forms) {
			g.transformation = FastMatrix3.identity();
			renderForm(formPainter, form, 0, 0, width, height);
		}
		g.end();
	}
	
	function renderForm(painter: FormPainter, form: Form, x: Float, y: Float, resx: Float, resy: Float) {
		painter.translate(x + form.x * resx, y + form.y * resy);
		form.render(painter);
		var resx = painter.resx;
		var resy = painter.resy;
		painter.resx = form.width * resx;
		painter.resy = form.height * resy;
		for (form2 in form.children) {
			renderForm(painter, form2, x + form.x * resx, y + form.y * resy, painter.resx, painter.resy);
		}
		painter.resx = resx;
		painter.resy = resy;
	}
}
