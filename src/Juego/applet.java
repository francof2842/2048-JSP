/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Juego;


import javax.swing.JApplet;
public class applet extends JApplet
{

    @Override
    public void init()
    {
        setLayout(null);
 
        ConsoleGame frame = new ConsoleGame();
 
        add(frame);
 
    }
    }