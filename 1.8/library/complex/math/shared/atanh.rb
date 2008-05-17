require 'complex'
require File.dirname(__FILE__) + '/../fixtures/classes'

shared :complex_math_atanh do |obj|
  describe "Math#{obj == Math ? '.' : '#'}atanh" do
    it "returns the inverse hyperbolic tangent of the argument" do
      obj.send(:atanh, 0.0).should == 0.0
      obj.send(:atanh, -0.0).should == -0.0
      obj.send(:atanh, 0.5).should be_close(0.549306144334055, TOLERANCE)
      obj.send(:atanh, -0.2).should be_close(-0.202732554054082, TOLERANCE)
    end

    it "returns Infinity for 1.0" do
      obj.send(:atanh, 1.0).infinite?.should == 1
    end

    it "returns -Infinity for -1.0" do
      obj.send(:atanh, -1.0).infinite?.should == -1
    end
    
    it "returns the inverse hyperbolic tangent as a Complex number for arguments greater than 1.0" do
      obj.send(:atanh, 1.0 + TOLERANCE).should be_close(Complex(5.55373767837521, 1.5707963267949), TOLERANCE)
      obj.send(:atanh, 10).should be_close(Complex(0.100335347731076, 1.5707963267949), TOLERANCE)
    end

    it "returns the inverse hyperbolic tangent as a Complex number for arguments greater than 1.0" do
      obj.send(:atanh, -1.0 - TOLERANCE).should be_close(Complex(-5.55373767837521, 1.5707963267949), TOLERANCE)
      obj.send(:atanh, 10).should be_close(Complex(0.100335347731076, 1.5707963267949), TOLERANCE)
    end
    
    it "returns the inverse hyperbolic tangent for Complex numbers" do
      obj.send(:atanh, Complex(3, 4)).should be_close(Complex(0.117500907311434, 1.40992104959658), TOLERANCE)
    end
  end
end

shared :complex_math_atanh_bang do |obj|
  describe "Math#{obj == Math ? '.' : '#'}atanh!" do
    it "returns the inverse hyperbolic tangent of the argument" do
      obj.send(:atanh!, 0.0).should == 0.0
      obj.send(:atanh!, -0.0).should == -0.0
      obj.send(:atanh!, 0.5).should be_close(0.549306144334055, TOLERANCE)
      obj.send(:atanh!, -0.2).should be_close(-0.202732554054082, TOLERANCE)
    end

    platform_is :darwin, :freebsd do
      it "returns Infinity for 1.0" do
        obj.send(:atanh!, 1.0).infinite?.should == 1
      end

      it "returns -Infinity for -1.0" do
        obj.send(:atanh!, -1.0).infinite?.should == -1
      end
    end

    platform_is :windows, :linux, :openbsd do
      it "raises an Errno::EDOM if x = 1.0" do
        lambda { obj.send(:atanh!, 1.0) }.should raise_error(Errno::EDOM)
      end

      it "raises an Errno::EDOM if x = -1.0" do
        lambda { obj.send(:atanh!, -1.0) }.should raise_error(Errno::EDOM)
      end
    end

    it "raises an Errno::EDOM for arguments greater than 1.0" do
      lambda { obj.send(:atanh!, 1.0 + TOLERANCE)  }.should raise_error(Errno::EDOM)
    end

    it "raises an Errno::EDOM for arguments less than -1.0" do
      lambda { obj.send(:atanh!, -1.0 - TOLERANCE) }.should raise_error(Errno::EDOM)
    end

    it "raises a TypeError when passed a Complex number" do
      lambda { obj.send(:atanh!, Complex(4, 5)) }.should raise_error(TypeError)
    end
  end
end