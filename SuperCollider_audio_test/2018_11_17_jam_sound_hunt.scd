(
SynthDef(\synth, {
    arg id, dist, align;
	var amp, trig, sig, env, flt, pitch, envFreq;
	envFreq = 2 / (dist + 0.2);
	trig = SinOsc.kr(envFreq);
	env = EnvGen.kr(Env.perc(0.01, 1 / envFreq), trig);
	pitch = (id*7+60).midicps - dist;
	sig = SinOsc.ar([pitch, pitch+1]) * SinOsc.ar([pitch*2, pitch*2+1]);
	sig = RLPF.ar(sig, 6000, 0.3);
	amp = align.max(0);
	Out.ar(0, env * amp * sig * 0.33);
}).add;
)

(
q = [
	Synth(\synth, [\id, 0, \dist, 5, \align, 0]),
	Synth(\synth, [\id, 1, \dist, 6, \align, 0]),
	Synth(\synth, [\id, 2, \dist, 7, \align, 0])
];
OSCdef('game', {
	arg msg;
	var foo, playerId, distance, alignment;
	# foo, playerId, distance, alignment = msg;

	q[playerId].set(\id, playerId);
	q[playerId].set(\dist, distance);
	q[playerId].set(\align, alignment);

	msg.postln;

}, "/playerInfo", recvPort: 12001);
)
