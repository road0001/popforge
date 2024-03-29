package de.popforge.widget.fl909
{
	import de.popforge.audio.output.Audio;
	import de.popforge.audio.output.AudioBuffer;
	import de.popforge.audio.processor.fl909.FL909;
	
	import flash.display.Sprite;

	public final class FL909Player extends Sprite
	{
		private var buffer: AudioBuffer;
		private var fl909: FL909;
		private var gui: FL909GUI;
		
		public function FL909Player()
		{
			init();
		}
		
		public function getFL909(): FL909
		{
			return fl909;
		}
		
		public function getAudioBuffer(): AudioBuffer
		{
			return buffer;
		}
		
		private function init(): void
		{
			fl909 = new FL909();
			
			gui = new FL909GUI( this );
			addChild( gui );
			
			buffer = new AudioBuffer( 4, Audio.STEREO, Audio.BIT16, Audio.RATE44100 );
			buffer.onInit = onAudioBufferInit;
			buffer.onComplete = onAudioBufferComplete;
		}
		
		private function onAudioBufferInit( buffer: AudioBuffer ): void
		{
			buffer.start();
		}
			
		private function onAudioBufferComplete( buffer: AudioBuffer ): void
		{
			var samples: Array = buffer.getSamples();
			
			fl909.processAudio( samples );
			
			buffer.update();
		}
	}
}