<?php

namespace Tests\Browser;

use Laravel\Dusk\Browser;
use Tests\DuskTestCase;

class UserRegistrationTest extends DuskTestCase
{
    public function test_user_registration()
    {
        $this->browse(function (Browser $browser) {
            $browser->visit('/test')
                ->press('Test')
                ->pause(2000) // Needs to wait for the response from the server Could use waitUtilSeen instead.
                ->assertSee('Hello from JS!')
                ->screenshot('user-registration');
        });
    }
}
