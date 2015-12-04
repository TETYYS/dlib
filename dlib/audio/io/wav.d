/*
Copyright (c) 2015 Timur Gafarov 

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/

module dlib.audio.io.wav;

import std.stdio;
import dlib.core.stream;
import dlib.filesystem.local;
import dlib.audio.sample;
import dlib.audio.sound;

/*
 * Simple RIFF/WAV decoder
 */

// Uncomment to see debug messages
//version = WAVDebug;

GenericSound loadWAV(string filename)
{
    auto istrm = openForInput(filename);
    auto snd = loadWAV(istrm);
    istrm.close();
    return snd;
}

GenericSound loadWAV(InputStream istrm)
{
    return loadWAV(istrm, defaultGenericSoundFactory);
}

GenericSound loadWAV(InputStream istrm, GenericSoundFactory gsf)
{
    char[4] magic;
    istrm.fillArray(magic);
    assert(magic == "RIFF");

    int chunkSize;
    istrm.readLE(&chunkSize);
    version(WAVDebug)
    {
        writeln(chunkSize);
    }

    char[4] format;
    istrm.fillArray(format);
    version(WAVDebug)
    {
        writeln(format);
    }
    assert(format == "WAVE");

    char[4] fmtSubchunkID; // fmt
    istrm.fillArray(fmtSubchunkID);

    int fmtSubchunkSize;
    istrm.readLE(&fmtSubchunkSize);

    short audioFormat;
    short numChannels;
    int sampleRate;
    int byteRate;
    short blockAlign;
    short bitsPerSample;

    istrm.readLE(&audioFormat);
    istrm.readLE(&numChannels);
    istrm.readLE(&sampleRate);
    istrm.readLE(&byteRate);
    istrm.readLE(&blockAlign);
    istrm.readLE(&bitsPerSample);

    version(WAVDebug)
    {
        writefln("Format: %s", audioFormat);
        writefln("Number of channels: %s", numChannels);
        writefln("Sample rate: %s Hz", sampleRate);
        writefln("Byte rate: %s", byteRate);
        writefln("Block align: %s", blockAlign);
        writefln("Bits per sample: %s", bitsPerSample);
    }

    char[4] dataSubchunkID; // data
    istrm.fillArray(dataSubchunkID);

    int dataSubchunkSize;
    istrm.readLE(&dataSubchunkSize);
    version(WAVDebug)
    {
        writeln(dataSubchunkSize);
    }
    int numSamples = dataSubchunkSize / (numChannels * bitsPerSample/8);
    version(WAVDebug)
    {
        writefln("Number of samples: %s", numSamples);
        writefln("Duration: %s", (cast(float)numSamples) / sampleRate);
    }

    SampleFormat f;
    if (bitsPerSample == 8)
    {
        f = SampleFormat.U8;
    }
    else if (bitsPerSample == 16)
    {
        f = SampleFormat.S16;
    }

    GenericSound gs;
    gs = gsf.createSound(
        dataSubchunkSize,
        numSamples,
        (cast(double)numSamples) / sampleRate,
        numChannels,
        sampleRate,
        bitsPerSample,
        f
    );
    istrm.fillArray(gs.data);

    return gs;
}

