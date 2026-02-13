<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TestController extends Controller
{
    public function test(Request $request)
    {
        if ($request->isMethod('POST')) {
            return response()->json(['message' => $request->get('test_input', 'No input provided')]);
        }

        return view('test');
    }
}